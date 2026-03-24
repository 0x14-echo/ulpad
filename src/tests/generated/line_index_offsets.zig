const std = @import("std");
const LineIndex = @import("ulpad").LineIndex;
const h = @import("../helpers.zig");

test "line index offset 0000-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0001-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0001-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0002-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("ab");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0002-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("ab");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0002-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("ab");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(2));
}

test "line index offset 0003-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0003-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0003-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(2));
}

test "line index offset 0003-03" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(3));
}

test "line index offset 0004-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0004-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(1));
}

test "line index offset 0005-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0005-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0005-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(2));
}

test "line index offset 0006-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\na");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0006-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\na");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(1));
}

test "line index offset 0006-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\na");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(2));
}

test "line index offset 0007-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0007-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0007-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(2));
}

test "line index offset 0007-03" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\nb");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(3));
}

test "line index offset 0008-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0008-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0008-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(2));
}

test "line index offset 0008-03" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("a\n\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(3));
}

test "line index offset 0009-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0009-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(1));
}

test "line index offset 0009-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("\n\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(2));
}

test "line index offset 0010-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0010-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0010-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(2));
}

test "line index offset 0010-03" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(3));
}

test "line index offset 0010-04" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(4));
}

test "line index offset 0010-05" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(5));
}

test "line index offset 0010-06" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(6));
}

test "line index offset 0010-07" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(7));
}

test "line index offset 0011-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0011-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0011-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(2));
}

test "line index offset 0011-03" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(3));
}

test "line index offset 0011-04" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(4));
}

test "line index offset 0011-05" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(5));
}

test "line index offset 0011-06" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(6));
}

test "line index offset 0011-07" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(7));
}

test "line index offset 0011-08" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("abc\ndef\n");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(8));
}

test "line index offset 0012-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0012-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0012-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(2));
}

test "line index offset 0012-03" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(3));
}

test "line index offset 0012-04" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(4));
}

test "line index offset 0012-05" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("x\ny\nz");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(5));
}

test "line index offset 0013-00" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(0));
}

test "line index offset 0013-01" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(1));
}

test "line index offset 0013-02" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(2));
}

test "line index offset 0013-03" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(3));
}

test "line index offset 0013-04" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(4));
}

test "line index offset 0013-05" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(5));
}

test "line index offset 0013-06" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 0), idx.lineOfOffset(6));
}

test "line index offset 0013-07" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(7));
}

test "line index offset 0013-08" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(8));
}

test "line index offset 0013-09" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(9));
}

test "line index offset 0013-10" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(10));
}

test "line index offset 0013-11" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 1), idx.lineOfOffset(11));
}

test "line index offset 0013-12" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(12));
}

test "line index offset 0013-13" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(13));
}

test "line index offset 0013-14" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(14));
}

test "line index offset 0013-15" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(15));
}

test "line index offset 0013-16" {
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild("longer\ntext\nhere");
    try std.testing.expectEqual(@as(usize, 2), idx.lineOfOffset(16));
}
