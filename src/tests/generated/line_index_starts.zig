const std = @import("std");
const LineIndex = @import("ulpad").LineIndex;
const h = @import("../helpers.zig");

test "line index start 0000-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0001-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0002-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("ab");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0003-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0004-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0004-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineStart(1));
}

test "line index start 0005-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0005-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineStart(1));
}

test "line index start 0006-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\na");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0006-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\na");
    try std.testing.expectEqual(@as(usize, 1), idx.lineStart(1));
}

test "line index start 0007-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0007-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb");
    try std.testing.expectEqual(@as(usize, 2), idx.lineStart(1));
}

test "line index start 0008-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0008-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineStart(1));
}

test "line index start 0008-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 3), idx.lineStart(2));
}

test "line index start 0009-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0009-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineStart(1));
}

test "line index start 0009-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineStart(2));
}

test "line index start 0010-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0010-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 4), idx.lineStart(1));
}

test "line index start 0011-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0011-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 4), idx.lineStart(1));
}

test "line index start 0011-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 8), idx.lineStart(2));
}

test "line index start 0012-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0012-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 2), idx.lineStart(1));
}

test "line index start 0012-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 4), idx.lineStart(2));
}

test "line index start 0013-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
}

test "line index start 0013-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 7), idx.lineStart(1));
}

test "line index start 0013-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 12), idx.lineStart(2));
}
