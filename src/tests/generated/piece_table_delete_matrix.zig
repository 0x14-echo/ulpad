const std = @import("std");
const PT = @import("ulpad").PieceTable;
const h = @import("../helpers.zig");

test "piece_table delete matrix 0000" {
    var t = try PT.initCopy(h.A, "");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0001" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "a");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0002" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0003" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "a");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0004" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "ab");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0005" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "b");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0006" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.delete(0, 2);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0007" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "ab");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0008" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.delete(1, 2);
    try h.expectTable(&t, "a");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0009" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.delete(2, 2);
    try h.expectTable(&t, "ab");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0010" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "abc");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0011" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "bc");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0012" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(0, 2);
    try h.expectTable(&t, "c");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0013" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(0, 3);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0014" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "abc");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0015" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(1, 2);
    try h.expectTable(&t, "ac");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0016" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(1, 3);
    try h.expectTable(&t, "a");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0017" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(2, 2);
    try h.expectTable(&t, "abc");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0018" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(2, 3);
    try h.expectTable(&t, "ab");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0019" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.delete(3, 3);
    try h.expectTable(&t, "abc");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0020" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "hello");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0021" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "ello");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0022" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(0, 2);
    try h.expectTable(&t, "llo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0023" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(0, 3);
    try h.expectTable(&t, "lo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0024" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(0, 4);
    try h.expectTable(&t, "o");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0025" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(0, 5);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0026" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "hello");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0027" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(1, 2);
    try h.expectTable(&t, "hllo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0028" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(1, 3);
    try h.expectTable(&t, "hlo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0029" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(1, 4);
    try h.expectTable(&t, "ho");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0030" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(1, 5);
    try h.expectTable(&t, "h");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0031" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(2, 2);
    try h.expectTable(&t, "hello");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0032" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(2, 3);
    try h.expectTable(&t, "helo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0033" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(2, 4);
    try h.expectTable(&t, "heo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0034" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(2, 5);
    try h.expectTable(&t, "he");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0035" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(3, 3);
    try h.expectTable(&t, "hello");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0036" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(3, 4);
    try h.expectTable(&t, "helo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0037" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(3, 5);
    try h.expectTable(&t, "hel");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0038" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(4, 4);
    try h.expectTable(&t, "hello");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0039" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(4, 5);
    try h.expectTable(&t, "hell");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0040" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.delete(5, 5);
    try h.expectTable(&t, "hello");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0041" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "world");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0042" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "orld");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0043" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(0, 2);
    try h.expectTable(&t, "rld");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0044" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(0, 3);
    try h.expectTable(&t, "ld");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0045" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(0, 4);
    try h.expectTable(&t, "d");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0046" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(0, 5);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0047" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "world");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0048" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(1, 2);
    try h.expectTable(&t, "wrld");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0049" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(1, 3);
    try h.expectTable(&t, "wld");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0050" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(1, 4);
    try h.expectTable(&t, "wd");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0051" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(1, 5);
    try h.expectTable(&t, "w");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0052" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(2, 2);
    try h.expectTable(&t, "world");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0053" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(2, 3);
    try h.expectTable(&t, "wold");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0054" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(2, 4);
    try h.expectTable(&t, "wod");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0055" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(2, 5);
    try h.expectTable(&t, "wo");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0056" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(3, 3);
    try h.expectTable(&t, "world");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0057" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(3, 4);
    try h.expectTable(&t, "word");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0058" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(3, 5);
    try h.expectTable(&t, "wor");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0059" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(4, 4);
    try h.expectTable(&t, "world");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0060" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(4, 5);
    try h.expectTable(&t, "worl");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0061" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.delete(5, 5);
    try h.expectTable(&t, "world");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0062" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "aaaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0063" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "aaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0064" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(0, 2);
    try h.expectTable(&t, "aa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0065" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(0, 3);
    try h.expectTable(&t, "a");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0066" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(0, 4);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0067" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "aaaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0068" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(1, 2);
    try h.expectTable(&t, "aaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0069" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(1, 3);
    try h.expectTable(&t, "aa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0070" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(1, 4);
    try h.expectTable(&t, "a");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0071" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(2, 2);
    try h.expectTable(&t, "aaaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0072" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(2, 3);
    try h.expectTable(&t, "aaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0073" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(2, 4);
    try h.expectTable(&t, "aa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0074" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(3, 3);
    try h.expectTable(&t, "aaaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0075" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(3, 4);
    try h.expectTable(&t, "aaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0076" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.delete(4, 4);
    try h.expectTable(&t, "aaaa");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0077" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "x\ny");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0078" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "\ny");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0079" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(0, 2);
    try h.expectTable(&t, "y");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0080" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(0, 3);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0081" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "x\ny");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0082" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(1, 2);
    try h.expectTable(&t, "xy");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0083" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(1, 3);
    try h.expectTable(&t, "x");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0084" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(2, 2);
    try h.expectTable(&t, "x\ny");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0085" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(2, 3);
    try h.expectTable(&t, "x\n");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0086" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.delete(3, 3);
    try h.expectTable(&t, "x\ny");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0087" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(0, 0);
    try h.expectTable(&t, "012345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0088" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(0, 1);
    try h.expectTable(&t, "12345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0089" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(0, 2);
    try h.expectTable(&t, "2345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0090" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(0, 3);
    try h.expectTable(&t, "345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0091" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(0, 4);
    try h.expectTable(&t, "45");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0092" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(0, 5);
    try h.expectTable(&t, "5");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0093" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(0, 6);
    try h.expectTable(&t, "");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0094" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(1, 1);
    try h.expectTable(&t, "012345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0095" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(1, 2);
    try h.expectTable(&t, "02345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0096" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(1, 3);
    try h.expectTable(&t, "0345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0097" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(1, 4);
    try h.expectTable(&t, "045");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0098" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(1, 5);
    try h.expectTable(&t, "05");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0099" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(1, 6);
    try h.expectTable(&t, "0");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0100" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(2, 2);
    try h.expectTable(&t, "012345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0101" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(2, 3);
    try h.expectTable(&t, "01345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0102" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(2, 4);
    try h.expectTable(&t, "0145");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0103" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(2, 5);
    try h.expectTable(&t, "015");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0104" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(2, 6);
    try h.expectTable(&t, "01");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0105" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(3, 3);
    try h.expectTable(&t, "012345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0106" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(3, 4);
    try h.expectTable(&t, "01245");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0107" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(3, 5);
    try h.expectTable(&t, "0125");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0108" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(3, 6);
    try h.expectTable(&t, "012");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0109" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(4, 4);
    try h.expectTable(&t, "012345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0110" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(4, 5);
    try h.expectTable(&t, "01235");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0111" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(4, 6);
    try h.expectTable(&t, "0123");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0112" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(5, 5);
    try h.expectTable(&t, "012345");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0113" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(5, 6);
    try h.expectTable(&t, "01234");
    try h.checkTable(&t);
}

test "piece_table delete matrix 0114" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.delete(6, 6);
    try h.expectTable(&t, "012345");
    try h.checkTable(&t);
}
