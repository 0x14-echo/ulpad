const std = @import("std");
const PT = @import("ulpad").PieceTable;
const h = @import("../helpers.zig");

test "piece_table insert matrix 0000" {
    var t = try PT.initCopy(h.A, "");
    defer t.deinit();
    try t.insert(0, "X");
    try h.expectTable(&t, "X");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0001" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    try t.insert(0, "YZ");
    try h.expectTable(&t, "YZa");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0002" {
    var t = try PT.initCopy(h.A, "a");
    defer t.deinit();
    try t.insert(1, "\n");
    try h.expectTable(&t, "a\n");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0003" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.insert(0, "\n");
    try h.expectTable(&t, "\nab");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0004" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.insert(1, "!");
    try h.expectTable(&t, "a!b");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0005" {
    var t = try PT.initCopy(h.A, "ab");
    defer t.deinit();
    try t.insert(2, "  ");
    try h.expectTable(&t, "ab  ");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0006" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.insert(0, "!");
    try h.expectTable(&t, "!abc");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0007" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.insert(1, "  ");
    try h.expectTable(&t, "a  bc");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0008" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.insert(2, "X");
    try h.expectTable(&t, "abXc");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0009" {
    var t = try PT.initCopy(h.A, "abc");
    defer t.deinit();
    try t.insert(3, "YZ");
    try h.expectTable(&t, "abcYZ");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0010" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.insert(0, "X");
    try h.expectTable(&t, "Xhello");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0011" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.insert(1, "YZ");
    try h.expectTable(&t, "hYZello");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0012" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.insert(2, "\n");
    try h.expectTable(&t, "he\nllo");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0013" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.insert(3, "!");
    try h.expectTable(&t, "hel!lo");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0014" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.insert(4, "  ");
    try h.expectTable(&t, "hell  o");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0015" {
    var t = try PT.initCopy(h.A, "hello");
    defer t.deinit();
    try t.insert(5, "X");
    try h.expectTable(&t, "helloX");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0016" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.insert(0, "X");
    try h.expectTable(&t, "Xworld");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0017" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.insert(1, "YZ");
    try h.expectTable(&t, "wYZorld");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0018" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.insert(2, "\n");
    try h.expectTable(&t, "wo\nrld");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0019" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.insert(3, "!");
    try h.expectTable(&t, "wor!ld");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0020" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.insert(4, "  ");
    try h.expectTable(&t, "worl  d");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0021" {
    var t = try PT.initCopy(h.A, "world");
    defer t.deinit();
    try t.insert(5, "X");
    try h.expectTable(&t, "worldX");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0022" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.insert(0, "  ");
    try h.expectTable(&t, "  aaaa");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0023" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.insert(1, "X");
    try h.expectTable(&t, "aXaaa");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0024" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.insert(2, "YZ");
    try h.expectTable(&t, "aaYZaa");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0025" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.insert(3, "\n");
    try h.expectTable(&t, "aaa\na");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0026" {
    var t = try PT.initCopy(h.A, "aaaa");
    defer t.deinit();
    try t.insert(4, "!");
    try h.expectTable(&t, "aaaa!");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0027" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(0, "\n");
    try h.expectTable(&t, "\nabc\ndef");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0028" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(1, "!");
    try h.expectTable(&t, "a!bc\ndef");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0029" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(2, "  ");
    try h.expectTable(&t, "ab  c\ndef");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0030" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(3, "X");
    try h.expectTable(&t, "abcX\ndef");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0031" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(4, "YZ");
    try h.expectTable(&t, "abc\nYZdef");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0032" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(5, "\n");
    try h.expectTable(&t, "abc\nd\nef");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0033" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(6, "!");
    try h.expectTable(&t, "abc\nde!f");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0034" {
    var t = try PT.initCopy(h.A, "abc\ndef");
    defer t.deinit();
    try t.insert(7, "  ");
    try h.expectTable(&t, "abc\ndef  ");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0035" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.insert(0, "!");
    try h.expectTable(&t, "!x\ny");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0036" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.insert(1, "  ");
    try h.expectTable(&t, "x  \ny");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0037" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.insert(2, "X");
    try h.expectTable(&t, "x\nXy");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0038" {
    var t = try PT.initCopy(h.A, "x\ny");
    defer t.deinit();
    try t.insert(3, "YZ");
    try h.expectTable(&t, "x\nyYZ");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0039" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.insert(0, "YZ");
    try h.expectTable(&t, "YZ012345");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0040" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.insert(1, "\n");
    try h.expectTable(&t, "0\n12345");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0041" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.insert(2, "!");
    try h.expectTable(&t, "01!2345");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0042" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.insert(3, "  ");
    try h.expectTable(&t, "012  345");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0043" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.insert(4, "X");
    try h.expectTable(&t, "0123X45");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0044" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.insert(5, "YZ");
    try h.expectTable(&t, "01234YZ5");
    try h.checkTable(&t);
}

test "piece_table insert matrix 0045" {
    var t = try PT.initCopy(h.A, "012345");
    defer t.deinit();
    try t.insert(6, "\n");
    try h.expectTable(&t, "012345\n");
    try h.checkTable(&t);
}
