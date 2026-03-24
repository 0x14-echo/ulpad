const std = @import("std");
const D = @import("ulpad").Document;
const h = @import("../helpers.zig");

test "document replace matrix 0000" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    try d.replaceRange(0, 0, "");
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document replace matrix 0001" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.replaceRange(0, 0, "X");
    try h.expectDoc(&d, "Xa");
    try h.checkDoc(&d);
}

test "document replace matrix 0002" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.replaceRange(0, 1, "\n");
    try h.expectDoc(&d, "\n");
    try h.checkDoc(&d);
}

test "document replace matrix 0003" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.replaceRange(1, 1, "");
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document replace matrix 0004" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.replaceRange(0, 0, "END");
    try h.expectDoc(&d, "ENDab");
    try h.checkDoc(&d);
}

test "document replace matrix 0005" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.replaceRange(0, 1, "X");
    try h.expectDoc(&d, "Xb");
    try h.checkDoc(&d);
}

test "document replace matrix 0006" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.replaceRange(0, 2, "\n");
    try h.expectDoc(&d, "\n");
    try h.checkDoc(&d);
}

test "document replace matrix 0007" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.replaceRange(1, 1, "END");
    try h.expectDoc(&d, "aENDb");
    try h.checkDoc(&d);
}

test "document replace matrix 0008" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.replaceRange(1, 2, "X");
    try h.expectDoc(&d, "aX");
    try h.checkDoc(&d);
}

test "document replace matrix 0009" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.replaceRange(2, 2, "\n");
    try h.expectDoc(&d, "ab\n");
    try h.checkDoc(&d);
}

test "document replace matrix 0010" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(0, 0, "");
    try h.expectDoc(&d, "abc");
    try h.checkDoc(&d);
}

test "document replace matrix 0011" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(0, 1, "ZZ");
    try h.expectDoc(&d, "ZZbc");
    try h.checkDoc(&d);
}

test "document replace matrix 0012" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(0, 2, "END");
    try h.expectDoc(&d, "ENDc");
    try h.checkDoc(&d);
}

test "document replace matrix 0013" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(0, 3, "X");
    try h.expectDoc(&d, "X");
    try h.checkDoc(&d);
}

test "document replace matrix 0014" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(1, 1, "X");
    try h.expectDoc(&d, "aXbc");
    try h.checkDoc(&d);
}

test "document replace matrix 0015" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(1, 2, "\n");
    try h.expectDoc(&d, "a\nc");
    try h.checkDoc(&d);
}

test "document replace matrix 0016" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(1, 3, "");
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document replace matrix 0017" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(2, 2, "X");
    try h.expectDoc(&d, "abXc");
    try h.checkDoc(&d);
}

test "document replace matrix 0018" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(2, 3, "\n");
    try h.expectDoc(&d, "ab\n");
    try h.checkDoc(&d);
}

test "document replace matrix 0019" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.replaceRange(3, 3, "");
    try h.expectDoc(&d, "abc");
    try h.checkDoc(&d);
}

test "document replace matrix 0020" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(0, 0, "");
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document replace matrix 0021" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(0, 1, "ZZ");
    try h.expectDoc(&d, "ZZello");
    try h.checkDoc(&d);
}

test "document replace matrix 0022" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(0, 2, "END");
    try h.expectDoc(&d, "ENDllo");
    try h.checkDoc(&d);
}

test "document replace matrix 0023" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(0, 3, "X");
    try h.expectDoc(&d, "Xlo");
    try h.checkDoc(&d);
}

test "document replace matrix 0024" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(0, 4, "\n");
    try h.expectDoc(&d, "\no");
    try h.checkDoc(&d);
}

test "document replace matrix 0025" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(0, 5, "");
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document replace matrix 0026" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(1, 1, "\n");
    try h.expectDoc(&d, "h\nello");
    try h.checkDoc(&d);
}

test "document replace matrix 0027" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(1, 2, "");
    try h.expectDoc(&d, "hllo");
    try h.checkDoc(&d);
}

test "document replace matrix 0028" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(1, 3, "ZZ");
    try h.expectDoc(&d, "hZZlo");
    try h.checkDoc(&d);
}

test "document replace matrix 0029" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(1, 4, "END");
    try h.expectDoc(&d, "hENDo");
    try h.checkDoc(&d);
}

test "document replace matrix 0030" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(1, 5, "X");
    try h.expectDoc(&d, "hX");
    try h.checkDoc(&d);
}

test "document replace matrix 0031" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(2, 2, "");
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document replace matrix 0032" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(2, 3, "ZZ");
    try h.expectDoc(&d, "heZZlo");
    try h.checkDoc(&d);
}

test "document replace matrix 0033" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(2, 4, "END");
    try h.expectDoc(&d, "heENDo");
    try h.checkDoc(&d);
}

test "document replace matrix 0034" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(2, 5, "X");
    try h.expectDoc(&d, "heX");
    try h.checkDoc(&d);
}

test "document replace matrix 0035" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(3, 3, "X");
    try h.expectDoc(&d, "helXlo");
    try h.checkDoc(&d);
}

test "document replace matrix 0036" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(3, 4, "\n");
    try h.expectDoc(&d, "hel\no");
    try h.checkDoc(&d);
}

test "document replace matrix 0037" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(3, 5, "");
    try h.expectDoc(&d, "hel");
    try h.checkDoc(&d);
}

test "document replace matrix 0038" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(4, 4, "X");
    try h.expectDoc(&d, "hellXo");
    try h.checkDoc(&d);
}

test "document replace matrix 0039" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(4, 5, "\n");
    try h.expectDoc(&d, "hell\n");
    try h.checkDoc(&d);
}

test "document replace matrix 0040" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.replaceRange(5, 5, "");
    try h.expectDoc(&d, "hello");
    try h.checkDoc(&d);
}

test "document replace matrix 0041" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(0, 0, "X");
    try h.expectDoc(&d, "Xworld");
    try h.checkDoc(&d);
}

test "document replace matrix 0042" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(0, 1, "\n");
    try h.expectDoc(&d, "\norld");
    try h.checkDoc(&d);
}

test "document replace matrix 0043" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(0, 2, "");
    try h.expectDoc(&d, "rld");
    try h.checkDoc(&d);
}

test "document replace matrix 0044" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(0, 3, "ZZ");
    try h.expectDoc(&d, "ZZld");
    try h.checkDoc(&d);
}

test "document replace matrix 0045" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(0, 4, "END");
    try h.expectDoc(&d, "ENDd");
    try h.checkDoc(&d);
}

test "document replace matrix 0046" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(0, 5, "X");
    try h.expectDoc(&d, "X");
    try h.checkDoc(&d);
}

test "document replace matrix 0047" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(1, 1, "END");
    try h.expectDoc(&d, "wENDorld");
    try h.checkDoc(&d);
}

test "document replace matrix 0048" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(1, 2, "X");
    try h.expectDoc(&d, "wXrld");
    try h.checkDoc(&d);
}

test "document replace matrix 0049" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(1, 3, "\n");
    try h.expectDoc(&d, "w\nld");
    try h.checkDoc(&d);
}

test "document replace matrix 0050" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(1, 4, "");
    try h.expectDoc(&d, "wd");
    try h.checkDoc(&d);
}

test "document replace matrix 0051" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(1, 5, "ZZ");
    try h.expectDoc(&d, "wZZ");
    try h.checkDoc(&d);
}

test "document replace matrix 0052" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(2, 2, "X");
    try h.expectDoc(&d, "woXrld");
    try h.checkDoc(&d);
}

test "document replace matrix 0053" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(2, 3, "\n");
    try h.expectDoc(&d, "wo\nld");
    try h.checkDoc(&d);
}

test "document replace matrix 0054" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(2, 4, "");
    try h.expectDoc(&d, "wod");
    try h.checkDoc(&d);
}

test "document replace matrix 0055" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(2, 5, "ZZ");
    try h.expectDoc(&d, "woZZ");
    try h.checkDoc(&d);
}

test "document replace matrix 0056" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(3, 3, "ZZ");
    try h.expectDoc(&d, "worZZld");
    try h.checkDoc(&d);
}

test "document replace matrix 0057" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(3, 4, "END");
    try h.expectDoc(&d, "worENDd");
    try h.checkDoc(&d);
}

test "document replace matrix 0058" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(3, 5, "X");
    try h.expectDoc(&d, "worX");
    try h.checkDoc(&d);
}

test "document replace matrix 0059" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(4, 4, "ZZ");
    try h.expectDoc(&d, "worlZZd");
    try h.checkDoc(&d);
}

test "document replace matrix 0060" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(4, 5, "END");
    try h.expectDoc(&d, "worlEND");
    try h.checkDoc(&d);
}

test "document replace matrix 0061" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.replaceRange(5, 5, "X");
    try h.expectDoc(&d, "worldX");
    try h.checkDoc(&d);
}

test "document replace matrix 0062" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(0, 0, "ZZ");
    try h.expectDoc(&d, "ZZaaaa");
    try h.checkDoc(&d);
}

test "document replace matrix 0063" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(0, 1, "END");
    try h.expectDoc(&d, "ENDaaa");
    try h.checkDoc(&d);
}

test "document replace matrix 0064" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(0, 2, "X");
    try h.expectDoc(&d, "Xaa");
    try h.checkDoc(&d);
}

test "document replace matrix 0065" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(0, 3, "\n");
    try h.expectDoc(&d, "\na");
    try h.checkDoc(&d);
}

test "document replace matrix 0066" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(0, 4, "");
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "document replace matrix 0067" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(1, 1, "END");
    try h.expectDoc(&d, "aENDaaa");
    try h.checkDoc(&d);
}

test "document replace matrix 0068" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(1, 2, "X");
    try h.expectDoc(&d, "aXaa");
    try h.checkDoc(&d);
}

test "document replace matrix 0069" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(1, 3, "\n");
    try h.expectDoc(&d, "a\na");
    try h.checkDoc(&d);
}

test "document replace matrix 0070" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(1, 4, "");
    try h.expectDoc(&d, "a");
    try h.checkDoc(&d);
}

test "document replace matrix 0071" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(2, 2, "");
    try h.expectDoc(&d, "aaaa");
    try h.checkDoc(&d);
}

test "document replace matrix 0072" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(2, 3, "ZZ");
    try h.expectDoc(&d, "aaZZa");
    try h.checkDoc(&d);
}

test "document replace matrix 0073" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(2, 4, "END");
    try h.expectDoc(&d, "aaEND");
    try h.checkDoc(&d);
}

test "document replace matrix 0074" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(3, 3, "");
    try h.expectDoc(&d, "aaaa");
    try h.checkDoc(&d);
}

test "document replace matrix 0075" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(3, 4, "ZZ");
    try h.expectDoc(&d, "aaaZZ");
    try h.checkDoc(&d);
}

test "document replace matrix 0076" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.replaceRange(4, 4, "END");
    try h.expectDoc(&d, "aaaaEND");
    try h.checkDoc(&d);
}

test "document replace matrix 0077" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(0, 0, "ZZ");
    try h.expectDoc(&d, "ZZx\ny");
    try h.checkDoc(&d);
}

test "document replace matrix 0078" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(0, 1, "END");
    try h.expectDoc(&d, "END\ny");
    try h.checkDoc(&d);
}

test "document replace matrix 0079" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(0, 2, "X");
    try h.expectDoc(&d, "Xy");
    try h.checkDoc(&d);
}

test "document replace matrix 0080" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(0, 3, "\n");
    try h.expectDoc(&d, "\n");
    try h.checkDoc(&d);
}

test "document replace matrix 0081" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(1, 1, "\n");
    try h.expectDoc(&d, "x\n\ny");
    try h.checkDoc(&d);
}

test "document replace matrix 0082" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(1, 2, "");
    try h.expectDoc(&d, "xy");
    try h.checkDoc(&d);
}

test "document replace matrix 0083" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(1, 3, "ZZ");
    try h.expectDoc(&d, "xZZ");
    try h.checkDoc(&d);
}

test "document replace matrix 0084" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(2, 2, "\n");
    try h.expectDoc(&d, "x\n\ny");
    try h.checkDoc(&d);
}

test "document replace matrix 0085" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(2, 3, "");
    try h.expectDoc(&d, "x\n");
    try h.checkDoc(&d);
}

test "document replace matrix 0086" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.replaceRange(3, 3, "ZZ");
    try h.expectDoc(&d, "x\nyZZ");
    try h.checkDoc(&d);
}

test "document replace matrix 0087" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(0, 0, "ZZ");
    try h.expectDoc(&d, "ZZ012345");
    try h.checkDoc(&d);
}

test "document replace matrix 0088" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(0, 1, "END");
    try h.expectDoc(&d, "END12345");
    try h.checkDoc(&d);
}

test "document replace matrix 0089" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(0, 2, "X");
    try h.expectDoc(&d, "X2345");
    try h.checkDoc(&d);
}

test "document replace matrix 0090" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(0, 3, "\n");
    try h.expectDoc(&d, "\n345");
    try h.checkDoc(&d);
}

test "document replace matrix 0091" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(0, 4, "");
    try h.expectDoc(&d, "45");
    try h.checkDoc(&d);
}

test "document replace matrix 0092" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(0, 5, "ZZ");
    try h.expectDoc(&d, "ZZ5");
    try h.checkDoc(&d);
}

test "document replace matrix 0093" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(0, 6, "END");
    try h.expectDoc(&d, "END");
    try h.checkDoc(&d);
}

test "document replace matrix 0094" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(1, 1, "X");
    try h.expectDoc(&d, "0X12345");
    try h.checkDoc(&d);
}

test "document replace matrix 0095" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(1, 2, "\n");
    try h.expectDoc(&d, "0\n2345");
    try h.checkDoc(&d);
}

test "document replace matrix 0096" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(1, 3, "");
    try h.expectDoc(&d, "0345");
    try h.checkDoc(&d);
}

test "document replace matrix 0097" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(1, 4, "ZZ");
    try h.expectDoc(&d, "0ZZ45");
    try h.checkDoc(&d);
}

test "document replace matrix 0098" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(1, 5, "END");
    try h.expectDoc(&d, "0END5");
    try h.checkDoc(&d);
}

test "document replace matrix 0099" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(1, 6, "X");
    try h.expectDoc(&d, "0X");
    try h.checkDoc(&d);
}

test "document replace matrix 0100" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(2, 2, "END");
    try h.expectDoc(&d, "01END2345");
    try h.checkDoc(&d);
}

test "document replace matrix 0101" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(2, 3, "X");
    try h.expectDoc(&d, "01X345");
    try h.checkDoc(&d);
}

test "document replace matrix 0102" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(2, 4, "\n");
    try h.expectDoc(&d, "01\n45");
    try h.checkDoc(&d);
}

test "document replace matrix 0103" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(2, 5, "");
    try h.expectDoc(&d, "015");
    try h.checkDoc(&d);
}

test "document replace matrix 0104" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(2, 6, "ZZ");
    try h.expectDoc(&d, "01ZZ");
    try h.checkDoc(&d);
}

test "document replace matrix 0105" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(3, 3, "X");
    try h.expectDoc(&d, "012X345");
    try h.checkDoc(&d);
}

test "document replace matrix 0106" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(3, 4, "\n");
    try h.expectDoc(&d, "012\n45");
    try h.checkDoc(&d);
}

test "document replace matrix 0107" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(3, 5, "");
    try h.expectDoc(&d, "0125");
    try h.checkDoc(&d);
}

test "document replace matrix 0108" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(3, 6, "ZZ");
    try h.expectDoc(&d, "012ZZ");
    try h.checkDoc(&d);
}

test "document replace matrix 0109" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(4, 4, "ZZ");
    try h.expectDoc(&d, "0123ZZ45");
    try h.checkDoc(&d);
}

test "document replace matrix 0110" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(4, 5, "END");
    try h.expectDoc(&d, "0123END5");
    try h.checkDoc(&d);
}

test "document replace matrix 0111" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(4, 6, "X");
    try h.expectDoc(&d, "0123X");
    try h.checkDoc(&d);
}

test "document replace matrix 0112" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(5, 5, "ZZ");
    try h.expectDoc(&d, "01234ZZ5");
    try h.checkDoc(&d);
}

test "document replace matrix 0113" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(5, 6, "END");
    try h.expectDoc(&d, "01234END");
    try h.checkDoc(&d);
}

test "document replace matrix 0114" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.replaceRange(6, 6, "X");
    try h.expectDoc(&d, "012345X");
    try h.checkDoc(&d);
}
