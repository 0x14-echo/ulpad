const std = @import("std");
const LineIndex = @import("ulpad").LineIndex;
const h = @import("../helpers.zig");

test "line index lineCount 0000" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("");
    try std.testing.expectEqual(@as(usize, 1), idx.lineCount());
    try h.checkLineIndex("", &idx);
}

test "line index lineCount 0001" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a");
    try std.testing.expectEqual(@as(usize, 1), idx.lineCount());
    try h.checkLineIndex("a", &idx);
}

test "line index lineCount 0002" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("ab");
    try std.testing.expectEqual(@as(usize, 1), idx.lineCount());
    try h.checkLineIndex("ab", &idx);
}

test "line index lineCount 0003" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc");
    try std.testing.expectEqual(@as(usize, 1), idx.lineCount());
    try h.checkLineIndex("abc", &idx);
}

test "line index lineCount 0004" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineCount());
    try h.checkLineIndex("\n", &idx);
}

test "line index lineCount 0005" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineCount());
    try h.checkLineIndex("a\n", &idx);
}

test "line index lineCount 0006" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\na");
    try std.testing.expectEqual(@as(usize, 2), idx.lineCount());
    try h.checkLineIndex("\na", &idx);
}

test "line index lineCount 0007" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb");
    try std.testing.expectEqual(@as(usize, 2), idx.lineCount());
    try h.checkLineIndex("a\nb", &idx);
}

test "line index lineCount 0008" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 3), idx.lineCount());
    try h.checkLineIndex("a\n\n", &idx);
}

test "line index lineCount 0009" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n\n");
    try std.testing.expectEqual(@as(usize, 3), idx.lineCount());
    try h.checkLineIndex("\n\n", &idx);
}

test "line index lineCount 0010" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 2), idx.lineCount());
    try h.checkLineIndex("abc\ndef", &idx);
}

test "line index lineCount 0011" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 3), idx.lineCount());
    try h.checkLineIndex("abc\ndef\n", &idx);
}

test "line index lineCount 0012" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 3), idx.lineCount());
    try h.checkLineIndex("x\ny\nz", &idx);
}

test "line index lineCount 0013" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 3), idx.lineCount());
    try h.checkLineIndex("longer\ntext\nhere", &idx);
}
