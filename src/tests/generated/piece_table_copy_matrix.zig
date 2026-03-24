const std = @import("std");
const PT = @import("ulpad").PieceTable;
const h = @import("../helpers.zig");

test "piece_table copy matrix 0000" {
    var t = try PT.initCopy(h.A, "");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0001" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0002" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("a", out);
}

test "piece_table copy matrix 0003" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0004" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0005" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("a", out);
}

test "piece_table copy matrix 0006" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("ab", out);
}

test "piece_table copy matrix 0007" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0008" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("b", out);
}

test "piece_table copy matrix 0009" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0010" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0011" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("a", out);
}

test "piece_table copy matrix 0012" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("ab", out);
}

test "piece_table copy matrix 0013" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("abc", out);
}

test "piece_table copy matrix 0014" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0015" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("b", out);
}

test "piece_table copy matrix 0016" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("bc", out);
}

test "piece_table copy matrix 0017" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0018" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("c", out);
}

test "piece_table copy matrix 0019" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0020" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0021" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("h", out);
}

test "piece_table copy matrix 0022" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("he", out);
}

test "piece_table copy matrix 0023" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("hel", out);
}

test "piece_table copy matrix 0024" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("hell", out);
}

test "piece_table copy matrix 0025" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("hello", out);
}

test "piece_table copy matrix 0026" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0027" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("e", out);
}

test "piece_table copy matrix 0028" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("el", out);
}

test "piece_table copy matrix 0029" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("ell", out);
}

test "piece_table copy matrix 0030" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("ello", out);
}

test "piece_table copy matrix 0031" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0032" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("l", out);
}

test "piece_table copy matrix 0033" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("ll", out);
}

test "piece_table copy matrix 0034" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("llo", out);
}

test "piece_table copy matrix 0035" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0036" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("l", out);
}

test "piece_table copy matrix 0037" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("lo", out);
}

test "piece_table copy matrix 0038" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0039" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("o", out);
}

test "piece_table copy matrix 0040" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 5, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0041" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0042" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("w", out);
}

test "piece_table copy matrix 0043" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("wo", out);
}

test "piece_table copy matrix 0044" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("wor", out);
}

test "piece_table copy matrix 0045" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("worl", out);
}

test "piece_table copy matrix 0046" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("world", out);
}

test "piece_table copy matrix 0047" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0048" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("o", out);
}

test "piece_table copy matrix 0049" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("or", out);
}

test "piece_table copy matrix 0050" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("orl", out);
}

test "piece_table copy matrix 0051" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("orld", out);
}

test "piece_table copy matrix 0052" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0053" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("r", out);
}

test "piece_table copy matrix 0054" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("rl", out);
}

test "piece_table copy matrix 0055" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("rld", out);
}

test "piece_table copy matrix 0056" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0057" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("l", out);
}

test "piece_table copy matrix 0058" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("ld", out);
}

test "piece_table copy matrix 0059" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0060" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("d", out);
}

test "piece_table copy matrix 0061" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 5, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0062" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0063" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("a", out);
}

test "piece_table copy matrix 0064" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("aa", out);
}

test "piece_table copy matrix 0065" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("aaa", out);
}

test "piece_table copy matrix 0066" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("aaaa", out);
}

test "piece_table copy matrix 0067" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0068" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("a", out);
}

test "piece_table copy matrix 0069" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("aa", out);
}

test "piece_table copy matrix 0070" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("aaa", out);
}

test "piece_table copy matrix 0071" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0072" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("a", out);
}

test "piece_table copy matrix 0073" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("aa", out);
}

test "piece_table copy matrix 0074" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0075" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("a", out);
}

test "piece_table copy matrix 0076" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0077" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0078" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("x", out);
}

test "piece_table copy matrix 0079" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("x\n", out);
}

test "piece_table copy matrix 0080" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("x\ny", out);
}

test "piece_table copy matrix 0081" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0082" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("\n", out);
}

test "piece_table copy matrix 0083" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("\ny", out);
}

test "piece_table copy matrix 0084" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0085" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("y", out);
}

test "piece_table copy matrix 0086" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0087" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 0);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0088" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("0", out);
}

test "piece_table copy matrix 0089" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("01", out);
}

test "piece_table copy matrix 0090" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("012", out);
}

test "piece_table copy matrix 0091" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("0123", out);
}

test "piece_table copy matrix 0092" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("01234", out);
}

test "piece_table copy matrix 0093" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 0, 6);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("012345", out);
}

test "piece_table copy matrix 0094" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 1);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0095" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("1", out);
}

test "piece_table copy matrix 0096" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("12", out);
}

test "piece_table copy matrix 0097" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("123", out);
}

test "piece_table copy matrix 0098" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("1234", out);
}

test "piece_table copy matrix 0099" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 1, 6);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("12345", out);
}

test "piece_table copy matrix 0100" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 2);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0101" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("2", out);
}

test "piece_table copy matrix 0102" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("23", out);
}

test "piece_table copy matrix 0103" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("234", out);
}

test "piece_table copy matrix 0104" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 2, 6);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("2345", out);
}

test "piece_table copy matrix 0105" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 3);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0106" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("3", out);
}

test "piece_table copy matrix 0107" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("34", out);
}

test "piece_table copy matrix 0108" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 3, 6);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("345", out);
}

test "piece_table copy matrix 0109" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 4);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0110" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("4", out);
}

test "piece_table copy matrix 0111" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 4, 6);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("45", out);
}

test "piece_table copy matrix 0112" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 5, 5);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}

test "piece_table copy matrix 0113" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 5, 6);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("5", out);
}

test "piece_table copy matrix 0114" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, 6, 6);
    defer h.A.free(out);
    try std.testing.expectEqualStrings("", out);
}
