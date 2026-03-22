const std = @import("std");
const Document = @import("document.zig").Document;
const Selection = @import("types.zig").Selection;
const ScreenSize = @import("types.zig").ScreenSize;
const Viewport = @import("types.zig").Viewport;

pub fn renderFrame(
    allocator: std.mem.Allocator,
    doc: *const Document,
    cursor: usize,
    selection: ?Selection,
    viewport: Viewport,
    screen: ScreenSize,
    status: []const u8,
    prompt: []const u8,
) ![]u8 {
    var out: std.ArrayList(u8) = .empty;
    errdefer out.deinit(allocator);

    const text_rows = if (screen.rows > 2) screen.rows - 2 else 1;
    try out.appendSlice(allocator, "\x1b[?25l\x1b[H");

    for (0..text_rows) |row| {
        const line = viewport.top_line + row;
        if (line < doc.lineCount()) {
            try appendDocumentLine(allocator, &out, doc, line, viewport.left_col, screen.cols, selection);
        } else {
            try out.append(allocator, '~');
        }
        try out.appendSlice(allocator, "\x1b[K\r\n");
    }

    try out.appendSlice(allocator, "\x1b[7m");
    try appendTruncated(&out, allocator, status, screen.cols);
    try out.appendSlice(allocator, "\x1b[m\x1b[K\r\n");
    try appendTruncated(&out, allocator, prompt, screen.cols);
    try out.appendSlice(allocator, "\x1b[K");

    const cursor_line = doc.lineOfOffset(cursor);
    const cursor_col = cursor - doc.lineStart(cursor_line);
    const screen_row = cursor_line - viewport.top_line + 1;
    const screen_col = cursor_col - viewport.left_col + 1;
    var cursor_buf: [64]u8 = undefined;
    const cursor_seq = try std.fmt.bufPrint(&cursor_buf, "\x1b[{d};{d}H\x1b[?25h", .{
        screen_row,
        screen_col,
    });
    try out.appendSlice(allocator, cursor_seq);

    return out.toOwnedSlice(allocator);
}

fn appendDocumentLine(
    allocator: std.mem.Allocator,
    out: *std.ArrayList(u8),
    doc: *const Document,
    line: usize,
    left_col: usize,
    cols: usize,
    selection: ?Selection,
) !void {
    const start = doc.lineStart(line);
    const content_end = doc.lineContentEnd(line);
    const line_bytes = try doc.sliceAlloc(allocator, start, content_end);
    defer allocator.free(line_bytes);

    const clipped = if (left_col >= line_bytes.len) "" else line_bytes[left_col..];
    const visible = clipped[0..@min(clipped.len, cols)];

    if (selection == null) {
        try out.appendSlice(allocator, visible);
        return;
    }

    const sel = selection.?;
    const visible_start = start + left_col;
    const visible_end = visible_start + visible.len;
    const overlap_start = @max(sel.start, visible_start);
    const overlap_end = @min(sel.end, visible_end);

    if (overlap_start >= overlap_end) {
        try out.appendSlice(allocator, visible);
        return;
    }

    const prefix_len = overlap_start - visible_start;
    const selected_len = overlap_end - overlap_start;
    try out.appendSlice(allocator, visible[0..prefix_len]);
    try out.appendSlice(allocator, "\x1b[7m");
    try out.appendSlice(allocator, visible[prefix_len .. prefix_len + selected_len]);
    try out.appendSlice(allocator, "\x1b[m");
    try out.appendSlice(allocator, visible[prefix_len + selected_len ..]);
}

fn appendTruncated(out: *std.ArrayList(u8), allocator: std.mem.Allocator, text: []const u8, cols: usize) !void {
    try out.appendSlice(allocator, text[0..@min(text.len, cols)]);
}

test "render frame includes document text and status line" {
    var doc = try Document.initCopy(std.testing.allocator, "alpha\nbeta");
    defer doc.deinit();

    const frame = try renderFrame(
        std.testing.allocator,
        &doc,
        1,
        .{ .start = 0, .end = 2 },
        .{},
        .{ .rows = 6, .cols = 20 },
        "status",
        "prompt",
    );
    defer std.testing.allocator.free(frame);

    try std.testing.expect(std.mem.indexOf(u8, frame, "\x1b[7mal\x1b[mpha") != null);
    try std.testing.expect(std.mem.indexOf(u8, frame, "\x1b[7mstatus") != null);
    try std.testing.expect(std.mem.indexOf(u8, frame, "prompt") != null);
}
