const std = @import("std");
const ulpad = @import("ulpad");
const D = ulpad.Document;
const R = ulpad.render;
const types = ulpad.types;
const A = std.testing.allocator;

fn mk(t: []const u8) !D {
    return D.initCopy(A, t);
}

// ═══════════════════════════════════════════════════
//  renderFrame — EP
// ═══════════════════════════════════════════════════
test "render: boş doküman tilde gösterir" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 5, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "~") != null);
}
test "render: tek satır düzgün görünür" {
    var d = try mk("hello");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 5, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "hello") != null);
}
test "render: çok satırlı tüm satırları gösterir" {
    var d = try mk("aaa\nbbb\nccc");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 8, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "aaa") != null);
    try std.testing.expect(std.mem.indexOf(u8, f, "bbb") != null);
    try std.testing.expect(std.mem.indexOf(u8, f, "ccc") != null);
}

// ═══════════════════════════════════════════════════
//  renderFrame — BVA: viewport
// ═══════════════════════════════════════════════════
test "render: viewport offset satırları gizler" {
    var d = try mk("aaa\nbbb\nccc\nddd");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 7, null, .{ .top_line = 2 }, .{ .rows = 8, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "aaa") == null);
    try std.testing.expect(std.mem.indexOf(u8, f, "bbb") == null);
    try std.testing.expect(std.mem.indexOf(u8, f, "ccc") != null);
}
test "render: horizontal viewport kırpar" {
    var d = try mk("0123456789ABCDEFGHIJ");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 10, null, .{ .left_col = 10 }, .{ .rows = 6, .cols = 10 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "ABCDEFGHIJ") != null);
}
test "render: screen.rows=3 minimum" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 3, .cols = 40 }, "s", "");
    defer A.free(f);
    try std.testing.expect(f.len > 0);
}
test "render: cursor viewport dışında crash yok" {
    var d = try mk("aaa\nbbb\nccc");
    defer d.deinit();
    // cursor_line=0, viewport.top_line=2 → underflow korunmalı
    const f = try R.renderFrame(A, &d, 0, null, .{ .top_line = 2 }, .{ .rows = 8, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(f.len > 0);
}
test "render: cursor viewport dışında crash yok (col)" {
    var d = try mk("abc");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{ .left_col = 5 }, .{ .rows = 5, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(f.len > 0);
}

// ═══════════════════════════════════════════════════
//  renderFrame — Selection
// ═══════════════════════════════════════════════════
test "render: selection başında reverse video" {
    var d = try mk("hello");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 3, .{ .start = 0, .end = 3 }, .{}, .{ .rows = 6, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "\x1b[7mhel\x1b[m") != null);
}
test "render: selection sonunda reverse video" {
    var d = try mk("hello");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 5, .{ .start = 3, .end = 5 }, .{}, .{ .rows = 6, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "hel\x1b[7mlo\x1b[m") != null);
}
test "render: selection yoksa reverse video yok" {
    var d = try mk("hello");
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 6, .cols = 40 }, "", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "hello") != null);
    try std.testing.expect(std.mem.indexOf(u8, f, "\x1b[7mh") == null);
}

// ═══════════════════════════════════════════════════
//  renderFrame — Status / Prompt
// ═══════════════════════════════════════════════════
test "render: status bar görünür" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 5, .cols = 40 }, "Ctrl-S save", "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "Ctrl-S save") != null);
}
test "render: status truncate edilir" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    const long = "X" ** 200;
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 6, .cols = 10 }, long, "");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "X" ** 200) == null);
}
test "render: prompt satırı görünür" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    const f = try R.renderFrame(A, &d, 0, null, .{}, .{ .rows = 6, .cols = 40 }, "", "Find: test");
    defer A.free(f);
    try std.testing.expect(std.mem.indexOf(u8, f, "Find: test") != null);
}
