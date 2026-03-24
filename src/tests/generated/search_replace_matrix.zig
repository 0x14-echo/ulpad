const std = @import("std");
const ulpad = @import("ulpad");
const D = ulpad.Document;
const S = ulpad.search;
const h = @import("../helpers.zig");

test "search replace matrix 0000" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    const count = try S.replaceAll(&d, "a", "x");
    try std.testing.expectEqual(@as(usize, 0), count);
    try h.expectDoc(&d, "");
    try h.checkDoc(&d);
}

test "search replace matrix 0001" {
    var d = try D.initCopy(h.A, "aaa");
    defer d.deinit();
    const count = try S.replaceAll(&d, "a", "a");
    try std.testing.expectEqual(@as(usize, 3), count);
    try h.expectDoc(&d, "aaa");
    try h.checkDoc(&d);
}

test "search replace matrix 0002" {
    var d = try D.initCopy(h.A, "aaa");
    defer d.deinit();
    const count = try S.replaceAll(&d, "a", "abc");
    try std.testing.expectEqual(@as(usize, 3), count);
    try h.expectDoc(&d, "abcabcabc");
    try h.checkDoc(&d);
}

test "search replace matrix 0003" {
    var d = try D.initCopy(h.A, "aaaaaa");
    defer d.deinit();
    const count = try S.replaceAll(&d, "aa", "b");
    try std.testing.expectEqual(@as(usize, 3), count);
    try h.expectDoc(&d, "bbb");
    try h.checkDoc(&d);
}

test "search replace matrix 0004" {
    var d = try D.initCopy(h.A, "a b c");
    defer d.deinit();
    const count = try S.replaceAll(&d, " ", "___");
    try std.testing.expectEqual(@as(usize, 2), count);
    try h.expectDoc(&d, "a___b___c");
    try h.checkDoc(&d);
}

test "search replace matrix 0005" {
    var d = try D.initCopy(h.A, "aXbXc");
    defer d.deinit();
    const count = try S.replaceAll(&d, "X", "");
    try std.testing.expectEqual(@as(usize, 2), count);
    try h.expectDoc(&d, "abc");
    try h.checkDoc(&d);
}

test "search replace matrix 0006" {
    var d = try D.initCopy(h.A, "foo bar foo");
    defer d.deinit();
    const count = try S.replaceAll(&d, "foo", "FOO");
    try std.testing.expectEqual(@as(usize, 2), count);
    try h.expectDoc(&d, "FOO bar FOO");
    try h.checkDoc(&d);
}

test "search replace matrix 0007" {
    var d = try D.initCopy(h.A, "v1.0.0");
    defer d.deinit();
    const count = try S.replaceAll(&d, "v1", "v2");
    try std.testing.expectEqual(@as(usize, 1), count);
    try h.expectDoc(&d, "v2.0.0");
    try h.checkDoc(&d);
}

test "search replace matrix 0008" {
    var d = try D.initCopy(h.A, "abcabcabc");
    defer d.deinit();
    const count = try S.replaceAll(&d, "abc", "a");
    try std.testing.expectEqual(@as(usize, 3), count);
    try h.expectDoc(&d, "aaa");
    try h.checkDoc(&d);
}

test "search replace matrix 0009" {
    var d = try D.initCopy(h.A, "hello world");
    defer d.deinit();
    const count = try S.replaceAll(&d, "xyz", "abc");
    try std.testing.expectEqual(@as(usize, 0), count);
    try h.expectDoc(&d, "hello world");
    try h.checkDoc(&d);
}
