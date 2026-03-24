const std = @import("std");
const LineIndex = @import("ulpad").LineIndex;
const h = @import("helpers.zig");

test "line_index: empty text has one line" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("");
    try std.testing.expectEqual(@as(usize, 1), idx.lineCount());
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line_index: single newline has two lines" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineCount());
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
    try std.testing.expectEqual(@as(usize, 1), idx.lineStart(1));
}

test "line_index: trailing newline creates extra line" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineCount());
    try std.testing.expectEqual(@as(usize, 4), idx.lineStart(1));
}

test "line_index: consecutive newlines create empty lines" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n\n");
    try std.testing.expectEqual(@as(usize, 4), idx.lineCount());
    try std.testing.expectEqual(@as(usize, 2), idx.lineStart(1));
    try std.testing.expectEqual(@as(usize, 3), idx.lineStart(2));
    try std.testing.expectEqual(@as(usize, 4), idx.lineStart(3));
}

test "line_index: lineContentEnd excludes newline" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 3), idx.lineContentEnd(0, 7));
    try std.testing.expectEqual(@as(usize, 7), idx.lineContentEnd(1, 7));
}

test "line_index: lineEnd includes newline boundary" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 4), idx.lineEnd(0, 7));
    try std.testing.expectEqual(@as(usize, 7), idx.lineEnd(1, 7));
}

test "line_index: lineOfOffset maps first line correctly" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\nghi");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(2));
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(3));
}

test "line_index: lineOfOffset maps middle line correctly" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\nghi");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(4));
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(6));
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(7));
}

test "line_index: lineOfOffset maps last line correctly" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\nghi");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(8));
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(10));
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(999));
}

test "line_index: rebuild resets old state" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb\nc");
    try std.testing.expectEqual(@as(usize, 3), idx.lineCount());
    try idx.rebuild("x");
    try std.testing.expectEqual(@as(usize, 1), idx.lineCount());
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}
