const std = @import("std");
const ulpad = @import("ulpad");
const types = ulpad.types;
const ansi = ulpad.ansi;
const tty = ulpad.tty;

test "types: ScreenSize stores rows and cols" {
    const s: types.ScreenSize = .{ .rows = 7, .cols = 19 };
    try std.testing.expectEqual(@as(usize, 7), s.rows);
    try std.testing.expectEqual(@as(usize, 19), s.cols);
}

test "types: Viewport defaults to zero" {
    const vp: types.Viewport = .{};
    try std.testing.expectEqual(@as(usize, 0), vp.top_line);
    try std.testing.expectEqual(@as(usize, 0), vp.left_col);
}

test "types: Viewport custom values" {
    const vp: types.Viewport = .{ .top_line = 3, .left_col = 9 };
    try std.testing.expectEqual(@as(usize, 3), vp.top_line);
    try std.testing.expectEqual(@as(usize, 9), vp.left_col);
}

test "types: Selection stores range" {
    const sel: types.Selection = .{ .start = 2, .end = 7 };
    try std.testing.expectEqual(@as(usize, 2), sel.start);
    try std.testing.expectEqual(@as(usize, 7), sel.end);
}

test "types: Key char variant" {
    const k = types.Key{ .char = 'x' };
    try std.testing.expectEqual(types.Key{ .char = 'x' }, k);
}

test "types: Key ctrl variant" {
    const k = types.Key{ .ctrl = 's' };
    try std.testing.expectEqual(types.Key{ .ctrl = 's' }, k);
}

test "ansi: enter alt screen exact" {
    try std.testing.expectEqualStrings("\x1b[?1049h", ansi.enter_alt_screen);
}

test "ansi: leave alt screen exact" {
    try std.testing.expectEqualStrings("\x1b[?1049l", ansi.leave_alt_screen);
}

test "ansi: clear screen exact" {
    try std.testing.expectEqualStrings("\x1b[2J", ansi.clear_screen);
}

test "ansi: cursor home exact" {
    try std.testing.expectEqualStrings("\x1b[H", ansi.cursor_home);
}

test "tty: ensureInteractive returns NotATerminal in test io" {
    try std.testing.expectError(error.NotATerminal, tty.ensureInteractive(std.testing.io));
}

test "tty: screenSize returns NotATerminal in test env" {
    try std.testing.expectError(error.NotATerminal, tty.screenSize());
}

test "tty: RawMode.leave inactive is no-op" {
    var mode: tty.RawMode = .{ .original = undefined, .active = false };
    mode.leave();
    try std.testing.expectEqual(false, mode.active);
}
