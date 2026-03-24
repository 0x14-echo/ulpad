const std = @import("std");
const ulpad = @import("ulpad");
const D = ulpad.Document;
const R = ulpad.render;
const h = @import("../helpers.zig");

test "render matrix 0000" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 5, .cols = 20 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0001" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 6, .cols = 10 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0002" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 1, .left_col = 0 }, .{ .rows = 8, .cols = 40 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0003" {
    var d = try D.initCopy(h.A, "");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 3 }, .{ .rows = 6, .cols = 8 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0004" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 5, .cols = 20 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0005" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 6, .cols = 10 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0006" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 1, .left_col = 0 }, .{ .rows = 8, .cols = 40 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0007" {
    var d = try D.initCopy(h.A, "hello");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 3 }, .{ .rows = 6, .cols = 8 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0008" {
    var d = try D.initCopy(h.A, "aaa\nbbb");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 5, .cols = 20 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0009" {
    var d = try D.initCopy(h.A, "aaa\nbbb");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 6, .cols = 10 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0010" {
    var d = try D.initCopy(h.A, "aaa\nbbb");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 1, .left_col = 0 }, .{ .rows = 8, .cols = 40 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0011" {
    var d = try D.initCopy(h.A, "aaa\nbbb");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 3 }, .{ .rows = 6, .cols = 8 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0012" {
    var d = try D.initCopy(h.A, "aaa\nbbb\nccc");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 5, .cols = 20 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0013" {
    var d = try D.initCopy(h.A, "aaa\nbbb\nccc");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 6, .cols = 10 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0014" {
    var d = try D.initCopy(h.A, "aaa\nbbb\nccc");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 1, .left_col = 0 }, .{ .rows = 8, .cols = 40 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0015" {
    var d = try D.initCopy(h.A, "aaa\nbbb\nccc");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 3 }, .{ .rows = 6, .cols = 8 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0016" {
    var d = try D.initCopy(h.A, "0123456789ABCDEFGHIJ");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 5, .cols = 20 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0017" {
    var d = try D.initCopy(h.A, "0123456789ABCDEFGHIJ");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 0 }, .{ .rows = 6, .cols = 10 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0018" {
    var d = try D.initCopy(h.A, "0123456789ABCDEFGHIJ");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 1, .left_col = 0 }, .{ .rows = 8, .cols = 40 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}

test "render matrix 0019" {
    var d = try D.initCopy(h.A, "0123456789ABCDEFGHIJ");
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{ .top_line = 0, .left_col = 3 }, .{ .rows = 6, .cols = 8 }, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}
