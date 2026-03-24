const std = @import("std");
const ulpad = @import("ulpad");
const input = ulpad.input;
const types = ulpad.types;
const clipboard = ulpad.clipboard;
const ansi = ulpad.ansi;
const tty = ulpad.tty;

test "clipboard set get 000" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("");
    try std.testing.expectEqualStrings("", cb.get());
}

test "clipboard osc52 000" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\x07"));
}

test "clipboard set get 001" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("a");
    try std.testing.expectEqualStrings("a", cb.get());
}

test "clipboard osc52 001" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "a");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\x07"));
}

test "clipboard set get 002" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("hello");
    try std.testing.expectEqualStrings("hello", cb.get());
}

test "clipboard osc52 002" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "hello");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\x07"));
}

test "clipboard set get 003" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("türkçe");
    try std.testing.expectEqualStrings("türkçe", cb.get());
}

test "clipboard osc52 003" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "türkçe");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\x07"));
}

test "clipboard set get 004" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("line1\nline2");
    try std.testing.expectEqualStrings("line1\nline2", cb.get());
}

test "clipboard osc52 004" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "line1\nline2");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\x07"));
}

test "clipboard set get 005" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    try std.testing.expectEqualStrings("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", cb.get());
}

test "clipboard osc52 005" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\x07"));
}

test "ansi constants exact" {
    try std.testing.expectEqualStrings("\x1b[?1049h", ansi.enter_alt_screen);
    try std.testing.expectEqualStrings("\x1b[?1049l", ansi.leave_alt_screen);
    try std.testing.expectEqualStrings("\x1b[2J", ansi.clear_screen);
    try std.testing.expectEqualStrings("\x1b[H", ansi.cursor_home);
}

test "types viewport defaults" {
    const vp: types.Viewport = .{};
    try std.testing.expectEqual(@as(usize, 0), vp.top_line);
    try std.testing.expectEqual(@as(usize, 0), vp.left_col);
}

test "tty ensureInteractive non-tty error" {
    try std.testing.expectError(error.NotATerminal, tty.ensureInteractive(std.testing.io));
}

test "tty screenSize non-tty error" {
    try std.testing.expectError(error.NotATerminal, tty.screenSize());
}

test "rawmode leave inactive no-op" {
    var mode: tty.RawMode = .{ .original = undefined, .active = false };
    mode.leave();
    try std.testing.expectEqual(false, mode.active);
}
