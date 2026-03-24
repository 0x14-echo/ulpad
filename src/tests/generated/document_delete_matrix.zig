const std = @import("std");
const D = @import("ulpad").Document;
const h = @import("../helpers.zig");

test "document delete matrix 0000" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0001" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document delete matrix 0002" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0003" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document delete matrix 0004" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "ab");
    try h.checkDoc(&d);
}

test "document delete matrix 0005" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "b");
    try h.checkDoc(&d);
}

test "document delete matrix 0006" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.delete(0, 2);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0007" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "ab");
    try h.checkDoc(&d);
}

test "document delete matrix 0008" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.delete(1, 2);
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document delete matrix 0009" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.delete(2, 2);
    try h.expectDoc(&d, "ab");
    try h.checkDoc(&d);
}

test "document delete matrix 0010" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "abc");
    try h.checkDoc(&d);
}

test "document delete matrix 0011" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "bc");
    try h.checkDoc(&d);
}

test "document delete matrix 0012" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(0, 2);
    try h.expectDoc(&d, "c");
    try h.checkDoc(&d);
}

test "document delete matrix 0013" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(0, 3);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0014" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "abc");
    try h.checkDoc(&d);
}

test "document delete matrix 0015" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(1, 2);
    try h.expectDoc(&d, "ac");
    try h.checkDoc(&d);
}

test "document delete matrix 0016" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(1, 3);
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document delete matrix 0017" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(2, 2);
    try h.expectDoc(&d, "abc");
    try h.checkDoc(&d);
}

test "document delete matrix 0018" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(2, 3);
    try h.expectDoc(&d, "ab");
    try h.checkDoc(&d);
}

test "document delete matrix 0019" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.delete(3, 3);
    try h.expectDoc(&d, "abc");
    try h.checkDoc(&d);
}

test "document delete matrix 0020" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document delete matrix 0021" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "ello");
    try h.checkDoc(&d);
}

test "document delete matrix 0022" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(0, 2);
    try h.expectDoc(&d, "llo");
    try h.checkDoc(&d);
}

test "document delete matrix 0023" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(0, 3);
    try h.expectDoc(&d, "lo");
    try h.checkDoc(&d);
}

test "document delete matrix 0024" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(0, 4);
    try h.expectDoc(&d, "o");
    try h.checkDoc(&d);
}

test "document delete matrix 0025" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(0, 5);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0026" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document delete matrix 0027" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(1, 2);
    try h.expectDoc(&d, "hllo");
    try h.checkDoc(&d);
}

test "document delete matrix 0028" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(1, 3);
    try h.expectDoc(&d, "hlo");
    try h.checkDoc(&d);
}

test "document delete matrix 0029" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(1, 4);
    try h.expectDoc(&d, "ho");
    try h.checkDoc(&d);
}

test "document delete matrix 0030" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(1, 5);
    try h.expectDoc(&d, "h");
    try h.checkDoc(&d);
}

test "document delete matrix 0031" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(2, 2);
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document delete matrix 0032" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(2, 3);
    try h.expectDoc(&d, "helo");
    try h.checkDoc(&d);
}

test "document delete matrix 0033" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(2, 4);
    try h.expectDoc(&d, "heo");
    try h.checkDoc(&d);
}

test "document delete matrix 0034" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(2, 5);
    try h.expectDoc(&d, "he");
    try h.checkDoc(&d);
}

test "document delete matrix 0035" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(3, 3);
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document delete matrix 0036" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(3, 4);
    try h.expectDoc(&d, "helo");
    try h.checkDoc(&d);
}

test "document delete matrix 0037" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(3, 5);
    try h.expectDoc(&d, "hel");
    try h.checkDoc(&d);
}

test "document delete matrix 0038" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(4, 4);
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document delete matrix 0039" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(4, 5);
    try h.expectDoc(&d, "hell");
    try h.checkDoc(&d);
}

test "document delete matrix 0040" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.delete(5, 5);
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document delete matrix 0041" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "world");
    try h.checkDoc(&d);
}

test "document delete matrix 0042" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "orld");
    try h.checkDoc(&d);
}

test "document delete matrix 0043" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(0, 2);
    try h.expectDoc(&d, "rld");
    try h.checkDoc(&d);
}

test "document delete matrix 0044" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(0, 3);
    try h.expectDoc(&d, "ld");
    try h.checkDoc(&d);
}

test "document delete matrix 0045" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(0, 4);
    try h.expectDoc(&d, "d");
    try h.checkDoc(&d);
}

test "document delete matrix 0046" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(0, 5);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0047" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "world");
    try h.checkDoc(&d);
}

test "document delete matrix 0048" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(1, 2);
    try h.expectDoc(&d, "wrld");
    try h.checkDoc(&d);
}

test "document delete matrix 0049" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(1, 3);
    try h.expectDoc(&d, "wld");
    try h.checkDoc(&d);
}

test "document delete matrix 0050" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(1, 4);
    try h.expectDoc(&d, "wd");
    try h.checkDoc(&d);
}

test "document delete matrix 0051" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(1, 5);
    try h.expectDoc(&d, "w");
    try h.checkDoc(&d);
}

test "document delete matrix 0052" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(2, 2);
    try h.expectDoc(&d, "world");
    try h.checkDoc(&d);
}

test "document delete matrix 0053" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(2, 3);
    try h.expectDoc(&d, "wold");
    try h.checkDoc(&d);
}

test "document delete matrix 0054" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(2, 4);
    try h.expectDoc(&d, "wod");
    try h.checkDoc(&d);
}

test "document delete matrix 0055" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(2, 5);
    try h.expectDoc(&d, "wo");
    try h.checkDoc(&d);
}

test "document delete matrix 0056" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(3, 3);
    try h.expectDoc(&d, "world");
    try h.checkDoc(&d);
}

test "document delete matrix 0057" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(3, 4);
    try h.expectDoc(&d, "word");
    try h.checkDoc(&d);
}

test "document delete matrix 0058" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(3, 5);
    try h.expectDoc(&d, "wor");
    try h.checkDoc(&d);
}

test "document delete matrix 0059" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(4, 4);
    try h.expectDoc(&d, "world");
    try h.checkDoc(&d);
}

test "document delete matrix 0060" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(4, 5);
    try h.expectDoc(&d, "worl");
    try h.checkDoc(&d);
}

test "document delete matrix 0061" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.delete(5, 5);
    try h.expectDoc(&d, "world");
    try h.checkDoc(&d);
}

test "document delete matrix 0062" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "aaaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0063" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "aaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0064" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(0, 2);
    try h.expectDoc(&d, "aa");
    try h.checkDoc(&d);
}

test "document delete matrix 0065" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(0, 3);
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document delete matrix 0066" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(0, 4);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0067" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "aaaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0068" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(1, 2);
    try h.expectDoc(&d, "aaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0069" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(1, 3);
    try h.expectDoc(&d, "aa");
    try h.checkDoc(&d);
}

test "document delete matrix 0070" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(1, 4);
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document delete matrix 0071" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(2, 2);
    try h.expectDoc(&d, "aaaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0072" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(2, 3);
    try h.expectDoc(&d, "aaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0073" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(2, 4);
    try h.expectDoc(&d, "aa");
    try h.checkDoc(&d);
}

test "document delete matrix 0074" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(3, 3);
    try h.expectDoc(&d, "aaaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0075" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(3, 4);
    try h.expectDoc(&d, "aaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0076" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.delete(4, 4);
    try h.expectDoc(&d, "aaaa");
    try h.checkDoc(&d);
}

test "document delete matrix 0077" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "x\ny");
    try h.checkDoc(&d);
}

test "document delete matrix 0078" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "\ny");
    try h.checkDoc(&d);
}

test "document delete matrix 0079" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(0, 2);
    try h.expectDoc(&d, "y");
    try h.checkDoc(&d);
}

test "document delete matrix 0080" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(0, 3);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0081" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "x\ny");
    try h.checkDoc(&d);
}

test "document delete matrix 0082" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(1, 2);
    try h.expectDoc(&d, "xy");
    try h.checkDoc(&d);
}

test "document delete matrix 0083" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(1, 3);
    try h.expectDoc(&d, "x");
    try h.checkDoc(&d);
}

test "document delete matrix 0084" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(2, 2);
    try h.expectDoc(&d, "x\ny");
    try h.checkDoc(&d);
}

test "document delete matrix 0085" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(2, 3);
    try h.expectDoc(&d, "x\n");
    try h.checkDoc(&d);
}

test "document delete matrix 0086" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.delete(3, 3);
    try h.expectDoc(&d, "x\ny");
    try h.checkDoc(&d);
}

test "document delete matrix 0087" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(0, 0);
    try h.expectDoc(&d, "012345");
    try h.checkDoc(&d);
}

test "document delete matrix 0088" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(0, 1);
    try h.expectDoc(&d, "12345");
    try h.checkDoc(&d);
}

test "document delete matrix 0089" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(0, 2);
    try h.expectDoc(&d, "2345");
    try h.checkDoc(&d);
}

test "document delete matrix 0090" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(0, 3);
    try h.expectDoc(&d, "345");
    try h.checkDoc(&d);
}

test "document delete matrix 0091" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(0, 4);
    try h.expectDoc(&d, "45");
    try h.checkDoc(&d);
}

test "document delete matrix 0092" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(0, 5);
    try h.expectDoc(&d, "5");
    try h.checkDoc(&d);
}

test "document delete matrix 0093" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(0, 6);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document delete matrix 0094" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(1, 1);
    try h.expectDoc(&d, "012345");
    try h.checkDoc(&d);
}

test "document delete matrix 0095" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(1, 2);
    try h.expectDoc(&d, "02345");
    try h.checkDoc(&d);
}

test "document delete matrix 0096" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(1, 3);
    try h.expectDoc(&d, "0345");
    try h.checkDoc(&d);
}

test "document delete matrix 0097" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(1, 4);
    try h.expectDoc(&d, "045");
    try h.checkDoc(&d);
}

test "document delete matrix 0098" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(1, 5);
    try h.expectDoc(&d, "05");
    try h.checkDoc(&d);
}

test "document delete matrix 0099" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(1, 6);
    try h.expectDoc(&d, "0");
    try h.checkDoc(&d);
}

test "document delete matrix 0100" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(2, 2);
    try h.expectDoc(&d, "012345");
    try h.checkDoc(&d);
}

test "document delete matrix 0101" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(2, 3);
    try h.expectDoc(&d, "01345");
    try h.checkDoc(&d);
}

test "document delete matrix 0102" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(2, 4);
    try h.expectDoc(&d, "0145");
    try h.checkDoc(&d);
}

test "document delete matrix 0103" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(2, 5);
    try h.expectDoc(&d, "015");
    try h.checkDoc(&d);
}

test "document delete matrix 0104" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(2, 6);
    try h.expectDoc(&d, "01");
    try h.checkDoc(&d);
}

test "document delete matrix 0105" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(3, 3);
    try h.expectDoc(&d, "012345");
    try h.checkDoc(&d);
}

test "document delete matrix 0106" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(3, 4);
    try h.expectDoc(&d, "01245");
    try h.checkDoc(&d);
}

test "document delete matrix 0107" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(3, 5);
    try h.expectDoc(&d, "0125");
    try h.checkDoc(&d);
}

test "document delete matrix 0108" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(3, 6);
    try h.expectDoc(&d, "012");
    try h.checkDoc(&d);
}

test "document delete matrix 0109" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(4, 4);
    try h.expectDoc(&d, "012345");
    try h.checkDoc(&d);
}

test "document delete matrix 0110" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(4, 5);
    try h.expectDoc(&d, "01235");
    try h.checkDoc(&d);
}

test "document delete matrix 0111" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(4, 6);
    try h.expectDoc(&d, "0123");
    try h.checkDoc(&d);
}

test "document delete matrix 0112" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(5, 5);
    try h.expectDoc(&d, "012345");
    try h.checkDoc(&d);
}

test "document delete matrix 0113" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(5, 6);
    try h.expectDoc(&d, "01234");
    try h.checkDoc(&d);
}

test "document delete matrix 0114" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.delete(6, 6);
    try h.expectDoc(&d, "012345");
    try h.checkDoc(&d);
}
