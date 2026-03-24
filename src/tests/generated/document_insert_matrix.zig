const std = @import("std");
const D = @import("ulpad").Document;
const h = @import("../helpers.zig");

test "document insert matrix 0000" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    try d.insert(0, "X");
    try h.expectDoc(&d, "X");
    try h.checkDoc(&d);
}

test "document insert matrix 0001" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.insert(0, "YZ");
    try h.expectDoc(&d, "YZa");
    try h.checkDoc(&d);
}

test "document insert matrix 0002" {
    var d = try D.initCopy(h.A, "a");
    defer d.deinit();
    try d.insert(1, "!");
    try h.expectDoc(&d, "a!");
    try h.checkDoc(&d);
}

test "document insert matrix 0003" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.insert(0, "!");
    try h.expectDoc(&d, "!ab");
    try h.checkDoc(&d);
}

test "document insert matrix 0004" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.insert(1, "X");
    try h.expectDoc(&d, "aXb");
    try h.checkDoc(&d);
}

test "document insert matrix 0005" {
    var d = try D.initCopy(h.A, "ab");
    defer d.deinit();
    try d.insert(2, "\n");
    try h.expectDoc(&d, "ab\n");
    try h.checkDoc(&d);
}

test "document insert matrix 0006" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.insert(0, "YZ");
    try h.expectDoc(&d, "YZabc");
    try h.checkDoc(&d);
}

test "document insert matrix 0007" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.insert(1, "!");
    try h.expectDoc(&d, "a!bc");
    try h.checkDoc(&d);
}

test "document insert matrix 0008" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.insert(2, "X");
    try h.expectDoc(&d, "abXc");
    try h.checkDoc(&d);
}

test "document insert matrix 0009" {
    var d = try D.initCopy(h.A, "abc");
    defer d.deinit();
    try d.insert(3, "\n");
    try h.expectDoc(&d, "abc\n");
    try h.checkDoc(&d);
}

test "document insert matrix 0010" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.insert(0, "X");
    try h.expectDoc(&d, "Xhello");
    try h.checkDoc(&d);
}

test "document insert matrix 0011" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.insert(1, "\n");
    try h.expectDoc(&d, "h\nello");
    try h.checkDoc(&d);
}

test "document insert matrix 0012" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.insert(2, "  ");
    try h.expectDoc(&d, "he  llo");
    try h.checkDoc(&d);
}

test "document insert matrix 0013" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.insert(3, "YZ");
    try h.expectDoc(&d, "helYZlo");
    try h.checkDoc(&d);
}

test "document insert matrix 0014" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.insert(4, "!");
    try h.expectDoc(&d, "hell!o");
    try h.checkDoc(&d);
}

test "document insert matrix 0015" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    try d.insert(5, "X");
    try h.expectDoc(&d, "helloX");
    try h.checkDoc(&d);
}

test "document insert matrix 0016" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.insert(0, "YZ");
    try h.expectDoc(&d, "YZworld");
    try h.checkDoc(&d);
}

test "document insert matrix 0017" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.insert(1, "!");
    try h.expectDoc(&d, "w!orld");
    try h.checkDoc(&d);
}

test "document insert matrix 0018" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.insert(2, "X");
    try h.expectDoc(&d, "woXrld");
    try h.checkDoc(&d);
}

test "document insert matrix 0019" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.insert(3, "\n");
    try h.expectDoc(&d, "wor\nld");
    try h.checkDoc(&d);
}

test "document insert matrix 0020" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.insert(4, "  ");
    try h.expectDoc(&d, "worl  d");
    try h.checkDoc(&d);
}

test "document insert matrix 0021" {
    var d = try D.initCopy(h.A, "world");
    defer d.deinit();
    try d.insert(5, "YZ");
    try h.expectDoc(&d, "worldYZ");
    try h.checkDoc(&d);
}

test "document insert matrix 0022" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.insert(0, "\n");
    try h.expectDoc(&d, "\naaaa");
    try h.checkDoc(&d);
}

test "document insert matrix 0023" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.insert(1, "  ");
    try h.expectDoc(&d, "a  aaa");
    try h.checkDoc(&d);
}

test "document insert matrix 0024" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.insert(2, "YZ");
    try h.expectDoc(&d, "aaYZaa");
    try h.checkDoc(&d);
}

test "document insert matrix 0025" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.insert(3, "!");
    try h.expectDoc(&d, "aaa!a");
    try h.checkDoc(&d);
}

test "document insert matrix 0026" {
    var d = try D.initCopy(h.A, "aaaa");
    defer d.deinit();
    try d.insert(4, "X");
    try h.expectDoc(&d, "aaaaX");
    try h.checkDoc(&d);
}

test "document insert matrix 0027" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(0, "\n");
    try h.expectDoc(&d, "\nabc\ndef");
    try h.checkDoc(&d);
}

test "document insert matrix 0028" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(1, "  ");
    try h.expectDoc(&d, "a  bc\ndef");
    try h.checkDoc(&d);
}

test "document insert matrix 0029" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(2, "YZ");
    try h.expectDoc(&d, "abYZc\ndef");
    try h.checkDoc(&d);
}

test "document insert matrix 0030" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(3, "!");
    try h.expectDoc(&d, "abc!\ndef");
    try h.checkDoc(&d);
}

test "document insert matrix 0031" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(4, "X");
    try h.expectDoc(&d, "abc\nXdef");
    try h.checkDoc(&d);
}

test "document insert matrix 0032" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(5, "\n");
    try h.expectDoc(&d, "abc\nd\nef");
    try h.checkDoc(&d);
}

test "document insert matrix 0033" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(6, "  ");
    try h.expectDoc(&d, "abc\nde  f");
    try h.checkDoc(&d);
}

test "document insert matrix 0034" {
    var d = try D.initCopy(h.A, "abc\ndef");
    defer d.deinit();
    try d.insert(7, "YZ");
    try h.expectDoc(&d, "abc\ndefYZ");
    try h.checkDoc(&d);
}

test "document insert matrix 0035" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.insert(0, "X");
    try h.expectDoc(&d, "Xx\ny");
    try h.checkDoc(&d);
}

test "document insert matrix 0036" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.insert(1, "\n");
    try h.expectDoc(&d, "x\n\ny");
    try h.checkDoc(&d);
}

test "document insert matrix 0037" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.insert(2, "  ");
    try h.expectDoc(&d, "x\n  y");
    try h.checkDoc(&d);
}

test "document insert matrix 0038" {
    var d = try D.initCopy(h.A, "x\ny");
    defer d.deinit();
    try d.insert(3, "YZ");
    try h.expectDoc(&d, "x\nyYZ");
    try h.checkDoc(&d);
}

test "document insert matrix 0039" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.insert(0, "  ");
    try h.expectDoc(&d, "  012345");
    try h.checkDoc(&d);
}

test "document insert matrix 0040" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.insert(1, "YZ");
    try h.expectDoc(&d, "0YZ12345");
    try h.checkDoc(&d);
}

test "document insert matrix 0041" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.insert(2, "!");
    try h.expectDoc(&d, "01!2345");
    try h.checkDoc(&d);
}

test "document insert matrix 0042" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.insert(3, "X");
    try h.expectDoc(&d, "012X345");
    try h.checkDoc(&d);
}

test "document insert matrix 0043" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.insert(4, "\n");
    try h.expectDoc(&d, "0123\n45");
    try h.checkDoc(&d);
}

test "document insert matrix 0044" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.insert(5, "  ");
    try h.expectDoc(&d, "01234  5");
    try h.checkDoc(&d);
}

test "document insert matrix 0045" {
    var d = try D.initCopy(h.A, "012345");
    defer d.deinit();
    try d.insert(6, "YZ");
    try h.expectDoc(&d, "012345YZ");
    try h.checkDoc(&d);
}
