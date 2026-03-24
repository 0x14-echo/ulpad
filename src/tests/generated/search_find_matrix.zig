const std = @import("std");
const ulpad = @import("ulpad");
const D = ulpad.Document;
const S = ulpad.search;
const h = @import("../helpers.zig");

test "search find matrix 0000" {
    var d = try D.initCopy(h.A, ""); defer d.deinit(); try h.expectNoFind(&d, "a", 0, .forward);
}

test "search find matrix 0001" {
    var d = try D.initCopy(h.A, "a"); defer d.deinit(); try h.expectFind(&d, "a", 0, .forward, 0, 1);
}

test "search find matrix 0002" {
    var d = try D.initCopy(h.A, "a"); defer d.deinit(); try h.expectFind(&d, "a", 0, .backward, 0, 1);
}

test "search find matrix 0003" {
    var d = try D.initCopy(h.A, "abc"); defer d.deinit(); try h.expectFind(&d, "bc", 0, .forward, 1, 3);
}

test "search find matrix 0004" {
    var d = try D.initCopy(h.A, "abc"); defer d.deinit(); try h.expectFind(&d, "bc", 2, .backward, 1, 3);
}

test "search find matrix 0005" {
    var d = try D.initCopy(h.A, "aaaa"); defer d.deinit(); try h.expectFind(&d, "aa", 0, .forward, 0, 2);
}

test "search find matrix 0006" {
    var d = try D.initCopy(h.A, "aaaa"); defer d.deinit(); try h.expectFind(&d, "aa", 1, .forward, 1, 3);
}

test "search find matrix 0007" {
    var d = try D.initCopy(h.A, "abc def abc"); defer d.deinit(); try h.expectFind(&d, "abc", 0, .forward, 0, 3);
}

test "search find matrix 0008" {
    var d = try D.initCopy(h.A, "abc def abc"); defer d.deinit(); try h.expectFind(&d, "abc", 11, .backward, 8, 11);
}

test "search find matrix 0009" {
    var d = try D.initCopy(h.A, "hello\nworld"); defer d.deinit(); try h.expectFind(&d, "world", 0, .forward, 6, 11);
}

test "search find matrix 0010" {
    var d = try D.initCopy(h.A, "cat dog cat bird cat"); defer d.deinit(); try h.expectFind(&d, "cat", 0, .forward, 0, 3);
}

test "search find matrix 0011" {
    var d = try D.initCopy(h.A, "cat dog cat bird cat"); defer d.deinit(); try h.expectFind(&d, "cat", 3, .forward, 8, 11);
}
