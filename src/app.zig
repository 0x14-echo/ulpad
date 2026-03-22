const std = @import("std");
const ansi = @import("ansi.zig");
const clipboard_mod = @import("clipboard.zig");
const Clipboard = clipboard_mod.Clipboard;
const Document = @import("document.zig").Document;
const io_mod = @import("editor_io.zig");
const editor_input = @import("input.zig");
const render = @import("render.zig");
const search = @import("search.zig");
const tty = @import("tty.zig");
const types = @import("types.zig");

const Key = types.Key;
const ScreenSize = types.ScreenSize;
const Selection = types.Selection;
const Viewport = types.Viewport;

const PromptKind = enum {
    none,
    find,
    replace_find,
    replace_with,
    replace_action,
    save_path,
};

const PromptState = struct {
    kind: PromptKind = .none,
    input: std.ArrayList(u8),
    needle: std.ArrayList(u8),
    replacement: std.ArrayList(u8),
    preview_cursor: usize = 0,

    fn init() PromptState {
        return .{
            .input = .empty,
            .needle = .empty,
            .replacement = .empty,
        };
    }

    fn deinit(self: *PromptState, allocator: std.mem.Allocator) void {
        self.input.deinit(allocator);
        self.needle.deinit(allocator);
        self.replacement.deinit(allocator);
    }

    fn clearInput(self: *PromptState) void {
        self.input.clearRetainingCapacity();
    }
};

const Editor = struct {
    allocator: std.mem.Allocator,
    io: std.Io,
    doc: Document,
    clipboard: Clipboard,
    cursor: usize,
    preferred_col: usize,
    selection_anchor: ?usize,
    viewport: Viewport,
    status: std.ArrayList(u8),
    prompt: PromptState,
    last_search: std.ArrayList(u8),
    file_path: ?[]u8,
    newline_mode: io_mod.NewlineMode,
    dirty: bool,
    quit_armed: bool,
    should_quit: bool,
    screen: ScreenSize,

    fn init(
        allocator: std.mem.Allocator,
        io: std.Io,
        path: ?[]const u8,
    ) !Editor {
        var doc: Document = undefined;
        var newline_mode: io_mod.NewlineMode = .lf;
        var owned_path: ?[]u8 = null;
        var dirty = false;

        if (path) |file_path| {
            const loaded = try io_mod.loadOrCreateDocument(allocator, io, file_path);
            doc = loaded.doc;
            newline_mode = loaded.newline_mode;
            owned_path = try allocator.dupe(u8, file_path);
            dirty = !loaded.file_exists;
        } else {
            doc = try Document.initEmpty(allocator);
        }
        errdefer doc.deinit();
        errdefer if (owned_path) |existing| allocator.free(existing);

        var editor = Editor{
            .allocator = allocator,
            .io = io,
            .doc = doc,
            .clipboard = Clipboard.init(allocator),
            .cursor = 0,
            .preferred_col = 0,
            .selection_anchor = null,
            .viewport = .{},
            .status = .empty,
            .prompt = PromptState.init(),
            .last_search = .empty,
            .file_path = owned_path,
            .newline_mode = newline_mode,
            .dirty = dirty,
            .quit_armed = false,
            .should_quit = false,
            .screen = .{ .rows = 24, .cols = 80 },
        };
        try editor.setStatus("Ctrl-S save | Ctrl-Q quit | Ctrl-B mark | Ctrl-F find | Ctrl-H replace");
        return editor;
    }

    fn deinit(self: *Editor) void {
        self.doc.deinit();
        self.clipboard.deinit();
        self.status.deinit(self.allocator);
        self.prompt.deinit(self.allocator);
        self.last_search.deinit(self.allocator);
        if (self.file_path) |path| self.allocator.free(path);
    }

    fn setStatus(self: *Editor, message: []const u8) !void {
        self.status.clearRetainingCapacity();
        try self.status.appendSlice(self.allocator, message);
    }

    fn setStatusFmt(self: *Editor, comptime fmt: []const u8, args: anytype) !void {
        var buffer: [256]u8 = undefined;
        const message = try std.fmt.bufPrint(&buffer, fmt, args);
        try self.setStatus(message);
    }

    fn activeSelection(self: *const Editor) ?Selection {
        if (self.selection_anchor) |anchor| {
            if (anchor == self.cursor) return null;
            return .{
                .start = @min(anchor, self.cursor),
                .end = @max(anchor, self.cursor),
            };
        }
        return null;
    }

    fn clearSelection(self: *Editor) void {
        self.selection_anchor = null;
    }

    fn promptLine(self: *Editor, allocator: std.mem.Allocator) ![]u8 {
        return switch (self.prompt.kind) {
            .none => allocator.dupe(u8, ""),
            .find => std.fmt.allocPrint(allocator, "Find: {s}", .{self.prompt.input.items}),
            .replace_find => std.fmt.allocPrint(allocator, "Replace find: {s}", .{self.prompt.input.items}),
            .replace_with => std.fmt.allocPrint(allocator, "Replace with: {s}", .{self.prompt.input.items}),
            .replace_action => std.fmt.allocPrint(
                allocator,
                "Replace '{s}' -> '{s}' | Enter=one a=all Esc=cancel",
                .{ self.prompt.needle.items, self.prompt.replacement.items },
            ),
            .save_path => std.fmt.allocPrint(allocator, "Save as: {s}", .{self.prompt.input.items}),
        };
    }

    fn run(self: *Editor) !void {
        try tty.ensureInteractive(self.io);
        var raw = try tty.enterRawMode();
        defer raw.leave();

        try writeAll(ansi.enter_alt_screen ++ ansi.clear_screen ++ ansi.cursor_home);
        defer writeAll("\x1b[?25h" ++ ansi.leave_alt_screen) catch {};

        while (!self.should_quit) {
            self.screen = try tty.screenSize();
            self.scrollCursorIntoView();
            try self.draw();

            const key = try editor_input.readKey(std.posix.STDIN_FILENO);
            if (key) |actual| {
                try self.handleKey(actual);
            }
        }
    }

    fn draw(self: *Editor) !void {
        const prompt_line = try self.promptLine(self.allocator);
        defer self.allocator.free(prompt_line);

        const frame = try render.renderFrame(
            self.allocator,
            &self.doc,
            self.cursor,
            self.activeSelection(),
            self.viewport,
            self.screen,
            self.status.items,
            prompt_line,
        );
        defer self.allocator.free(frame);

        try writeAll(frame);
    }

    fn handleKey(self: *Editor, key: Key) !void {
        if (self.prompt.kind != .none) {
            try self.handlePromptKey(key);
            return;
        }

        self.quit_armed = false;
        switch (key) {
            .arrow_left => self.moveLeft(),
            .arrow_right => self.moveRight(),
            .arrow_up => self.moveVertical(-1),
            .arrow_down => self.moveVertical(1),
            .home => self.moveHome(),
            .end => self.moveEnd(),
            .page_up => self.movePage(-1),
            .page_down => self.movePage(1),
            .backspace => try self.backspace(),
            .delete => try self.deleteForward(),
            .enter => try self.insertBytes("\n"),
            .tab => try self.insertBytes("    "),
            .char => |byte| if (byte >= 32) try self.insertByte(byte),
            .ctrl => |byte| try self.handleCtrl(byte),
            else => {},
        }
    }

    fn handleCtrl(self: *Editor, byte: u8) !void {
        switch (byte) {
            'q' => {
                if (self.dirty and !self.quit_armed) {
                    self.quit_armed = true;
                    try self.setStatus("Unsaved changes. Press Ctrl-Q again to quit.");
                } else {
                    self.should_quit = true;
                }
            },
            's' => try self.save(),
            'f' => try self.openFindPrompt(),
            'h' => try self.openReplacePrompt(),
            'c' => try self.copySelection(),
            'x' => try self.cutSelection(),
            'v' => try self.pasteClipboard(),
            'b' => self.toggleSelection(),
            'n' => try self.jumpSearch(.forward),
            'p' => try self.jumpSearch(.backward),
            else => {},
        }
    }

    fn handlePromptKey(self: *Editor, key: Key) !void {
        switch (self.prompt.kind) {
            .find, .replace_find, .replace_with, .save_path => try self.handleTextPromptKey(key),
            .replace_action => try self.handleReplaceActionKey(key),
            .none => {},
        }
    }

    fn handleTextPromptKey(self: *Editor, key: Key) !void {
        switch (key) {
            .escape => {
                if (self.prompt.kind == .find or self.prompt.kind == .replace_find) {
                    self.cursor = self.prompt.preview_cursor;
                }
                self.prompt.kind = .none;
                try self.setStatus("Canceled");
            },
            .backspace => {
                _ = self.prompt.input.pop();
                try self.afterPromptEdit();
            },
            .enter => try self.finishPrompt(),
            .char => |byte| {
                if (byte >= 32) {
                    try self.prompt.input.append(self.allocator, byte);
                    try self.afterPromptEdit();
                }
            },
            else => {},
        }
    }

    fn handleReplaceActionKey(self: *Editor, key: Key) !void {
        switch (key) {
            .escape => {
                self.prompt.kind = .none;
                try self.setStatus("Replace canceled");
            },
            .enter => try self.replaceOne(),
            .char => |byte| if (byte == 'a') {
                const count = try search.replaceAll(&self.doc, self.prompt.needle.items, self.prompt.replacement.items);
                self.prompt.kind = .none;
                self.dirty = self.dirty or count != 0;
                self.clearSelection();
                try self.setStatusFmt("Replaced {d} matches", .{count});
            },
            else => {},
        }
    }

    fn afterPromptEdit(self: *Editor) !void {
        if (self.prompt.kind == .find or self.prompt.kind == .replace_find) {
            if (self.prompt.input.items.len == 0) {
                self.cursor = self.prompt.preview_cursor;
                return;
            }

            if (try search.find(&self.doc, self.prompt.input.items, self.prompt.preview_cursor, .forward)) |match| {
                self.cursor = match.start;
            } else {
                try self.setStatus("Not found");
            }
        }
    }

    fn finishPrompt(self: *Editor) !void {
        switch (self.prompt.kind) {
            .find => {
                try self.last_search.resize(self.allocator, 0);
                try self.last_search.appendSlice(self.allocator, self.prompt.input.items);
                self.prompt.kind = .none;
                try self.setStatusFmt("Search: {s}", .{self.last_search.items});
            },
            .replace_find => {
                self.prompt.needle.clearRetainingCapacity();
                try self.prompt.needle.appendSlice(self.allocator, self.prompt.input.items);
                self.prompt.clearInput();
                self.prompt.kind = .replace_with;
            },
            .replace_with => {
                self.prompt.replacement.clearRetainingCapacity();
                try self.prompt.replacement.appendSlice(self.allocator, self.prompt.input.items);
                self.prompt.clearInput();
                self.prompt.kind = .replace_action;
                try self.setStatus("Enter=replace one | a=replace all");
            },
            .save_path => {
                if (self.prompt.input.items.len == 0) return;
                if (self.file_path) |path| self.allocator.free(path);
                self.file_path = try self.allocator.dupe(u8, self.prompt.input.items);
                self.prompt.kind = .none;
                try self.save();
            },
            else => {},
        }
    }

    fn openFindPrompt(self: *Editor) !void {
        self.prompt.kind = .find;
        self.prompt.preview_cursor = self.cursor;
        self.prompt.clearInput();
    }

    fn openReplacePrompt(self: *Editor) !void {
        self.prompt.kind = .replace_find;
        self.prompt.preview_cursor = self.cursor;
        self.prompt.clearInput();
        self.prompt.needle.clearRetainingCapacity();
        self.prompt.replacement.clearRetainingCapacity();
    }

    fn save(self: *Editor) !void {
        if (self.file_path == null) {
            self.prompt.kind = .save_path;
            self.prompt.clearInput();
            return;
        }

        try io_mod.saveDocument(self.allocator, self.io, &self.doc, self.file_path.?, self.newline_mode);
        self.dirty = false;
        try self.setStatusFmt("Saved {s}", .{self.file_path.?});
    }

    fn copySelection(self: *Editor) !void {
        const selection = self.activeSelection() orelse return;
        const text = try self.doc.sliceAlloc(self.allocator, selection.start, selection.end);
        defer self.allocator.free(text);

        try self.clipboard.set(text);
        const osc52 = try self.clipboard.osc52SequenceAlloc(self.allocator);
        defer self.allocator.free(osc52);
        try writeAll(osc52);
        try self.setStatus("Copied selection");
    }

    fn cutSelection(self: *Editor) !void {
        const selection = self.activeSelection() orelse return;
        try self.copySelection();
        try self.doc.delete(selection.start, selection.end);
        self.cursor = selection.start;
        self.clearSelection();
        self.dirty = true;
        try self.setStatus("Cut selection");
    }

    fn pasteClipboard(self: *Editor) !void {
        const external = try clipboard_mod.tryReadSystem(self.allocator, self.io);
        defer if (external) |bytes| self.allocator.free(bytes);

        const bytes = if (external) |system_bytes|
            system_bytes
        else
            self.clipboard.get();

        if (bytes.len == 0) return;
        try self.insertBytes(bytes);
        try self.setStatus("Pasted");
    }

    fn replaceOne(self: *Editor) !void {
        const match = (try search.find(&self.doc, self.prompt.needle.items, self.cursor, .forward)) orelse {
            try self.setStatus("No further matches");
            return;
        };

        try self.doc.replaceRange(match.start, match.end, self.prompt.replacement.items);
        self.cursor = match.start + self.prompt.replacement.items.len;
        self.clearSelection();
        self.dirty = true;
        try self.setStatus("Replaced one match");
    }

    fn jumpSearch(self: *Editor, direction: search.Direction) !void {
        if (self.last_search.items.len == 0) return;

        const start = switch (direction) {
            .forward => self.cursor + @min(@as(usize, 1), self.doc.byteLen() - @min(self.cursor, self.doc.byteLen())),
            .backward => self.cursor,
        };

        if (try search.find(&self.doc, self.last_search.items, start, direction)) |match| {
            self.cursor = match.start;
            try self.setStatusFmt("Match at {d}", .{match.start});
        } else {
            try self.setStatus("No match");
        }
    }

    fn toggleSelection(self: *Editor) void {
        if (self.selection_anchor == null) {
            self.selection_anchor = self.cursor;
        } else {
            self.selection_anchor = null;
        }
    }

    fn insertByte(self: *Editor, byte: u8) !void {
        var one = [1]u8{byte};
        try self.insertBytes(&one);
    }

    fn insertBytes(self: *Editor, bytes: []const u8) !void {
        if (self.activeSelection()) |selection| {
            try self.doc.replaceRange(selection.start, selection.end, bytes);
            self.cursor = selection.start + bytes.len;
            self.clearSelection();
        } else {
            try self.doc.insert(self.cursor, bytes);
            self.cursor += bytes.len;
        }
        self.dirty = true;
        self.preferred_col = self.cursorColumn();
    }

    fn backspace(self: *Editor) !void {
        if (self.activeSelection()) |selection| {
            try self.doc.delete(selection.start, selection.end);
            self.cursor = selection.start;
            self.clearSelection();
            self.dirty = true;
            return;
        }

        if (self.cursor == 0) return;
        try self.doc.delete(self.cursor - 1, self.cursor);
        self.cursor -= 1;
        self.dirty = true;
        self.preferred_col = self.cursorColumn();
    }

    fn deleteForward(self: *Editor) !void {
        if (self.activeSelection()) |selection| {
            try self.doc.delete(selection.start, selection.end);
            self.cursor = selection.start;
            self.clearSelection();
            self.dirty = true;
            return;
        }
        if (self.cursor >= self.doc.byteLen()) return;
        try self.doc.delete(self.cursor, self.cursor + 1);
        self.dirty = true;
    }

    fn moveLeft(self: *Editor) void {
        if (self.cursor > 0) self.cursor -= 1;
        self.preferred_col = self.cursorColumn();
    }

    fn moveRight(self: *Editor) void {
        if (self.cursor < self.doc.byteLen()) self.cursor += 1;
        self.preferred_col = self.cursorColumn();
    }

    fn moveHome(self: *Editor) void {
        const line = self.doc.lineOfOffset(self.cursor);
        self.cursor = self.doc.lineStart(line);
        self.preferred_col = 0;
    }

    fn moveEnd(self: *Editor) void {
        const line = self.doc.lineOfOffset(self.cursor);
        self.cursor = self.doc.lineContentEnd(line);
        self.preferred_col = self.cursorColumn();
    }

    fn moveVertical(self: *Editor, delta: isize) void {
        const current_line = self.doc.lineOfOffset(self.cursor);
        const target_line_signed = @as(isize, @intCast(current_line)) + delta;
        const target_line = if (target_line_signed < 0)
            @as(usize, 0)
        else
            @min(@as(usize, @intCast(target_line_signed)), self.doc.lineCount() - 1);
        const target_start = self.doc.lineStart(target_line);
        const target_end = self.doc.lineContentEnd(target_line);
        self.cursor = @min(target_start + self.preferred_col, target_end);
    }

    fn movePage(self: *Editor, direction: isize) void {
        const text_rows = if (self.screen.rows > 2) self.screen.rows - 2 else 1;
        var steps = text_rows;
        while (steps > 0) : (steps -= 1) {
            self.moveVertical(direction);
        }
    }

    fn cursorColumn(self: *const Editor) usize {
        const line = self.doc.lineOfOffset(self.cursor);
        return self.cursor - self.doc.lineStart(line);
    }

    fn scrollCursorIntoView(self: *Editor) void {
        const text_rows = if (self.screen.rows > 2) self.screen.rows - 2 else 1;
        const line = self.doc.lineOfOffset(self.cursor);
        const col = self.cursorColumn();

        if (line < self.viewport.top_line) {
            self.viewport.top_line = line;
        } else if (line >= self.viewport.top_line + text_rows) {
            self.viewport.top_line = line - text_rows + 1;
        }

        if (col < self.viewport.left_col) {
            self.viewport.left_col = col;
        } else if (col >= self.viewport.left_col + self.screen.cols) {
            self.viewport.left_col = col - self.screen.cols + 1;
        }
    }
};

pub fn run(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);
    const path = if (args.len > 1) args[1] else null;

    var editor = try Editor.init(init.gpa, init.io, path);
    defer editor.deinit();
    try editor.run();
}

fn writeAll(bytes: []const u8) !void {
    const linux = std.os.linux;
    var written: usize = 0;
    while (written < bytes.len) {
        const rc = linux.write(std.posix.STDOUT_FILENO, bytes[written..].ptr, bytes.len - written);
        switch (std.posix.errno(rc)) {
            .SUCCESS => written += rc,
            .INTR => continue,
            else => return error.WriteFailed,
        }
    }
}

test "editor init treats missing path as a new dirty document" {
    var editor = try Editor.init(std.testing.allocator, std.testing.io, "ulpad-missing-editor-991d8d4f");
    defer editor.deinit();

    try std.testing.expect(editor.file_path != null);
    try std.testing.expectEqualStrings("ulpad-missing-editor-991d8d4f", editor.file_path.?);
    try std.testing.expect(editor.dirty);
    try std.testing.expectEqual(@as(usize, 1), editor.doc.lineCount());
}
