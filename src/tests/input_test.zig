const std = @import("std");
const ulpad = @import("ulpad");
const input = ulpad.input;
const types = ulpad.types;
const clipboard = ulpad.clipboard;

// ═══════════════════════════════════════════════════
//  parseKey — EP: Ctrl tuşları
// ═══════════════════════════════════════════════════
test "input: Ctrl+A (1)" {
    const p = input.parseKey(&.{1}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'a' }, p.key);
}
test "input: Ctrl+B (2)" {
    const p = input.parseKey(&.{2}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'b' }, p.key);
}
test "input: Ctrl+C (3)" {
    const p = input.parseKey(&.{3}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'c' }, p.key);
}
test "input: Ctrl+D (4)" {
    const p = input.parseKey(&.{4}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'd' }, p.key);
}
test "input: Ctrl+E (5)" {
    const p = input.parseKey(&.{5}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'e' }, p.key);
}
test "input: Ctrl+F (6)" {
    const p = input.parseKey(&.{6}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'f' }, p.key);
}
test "input: Ctrl+G (7)" {
    const p = input.parseKey(&.{7}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'g' }, p.key);
}
test "input: Ctrl+H (8)" {
    const p = input.parseKey(&.{8}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'h' }, p.key);
}
test "input: Ctrl+K (11)" {
    const p = input.parseKey(&.{11}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'k' }, p.key);
}
test "input: Ctrl+N (14)" {
    const p = input.parseKey(&.{14}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'n' }, p.key);
}
test "input: Ctrl+P (16)" {
    const p = input.parseKey(&.{16}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'p' }, p.key);
}
test "input: Ctrl+Q (17)" {
    const p = input.parseKey(&.{17}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'q' }, p.key);
}
test "input: Ctrl+S (19)" {
    const p = input.parseKey(&.{19}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 's' }, p.key);
}
test "input: Ctrl+U (21)" {
    const p = input.parseKey(&.{21}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'u' }, p.key);
}
test "input: Ctrl+W (23)" {
    const p = input.parseKey(&.{23}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'w' }, p.key);
}
test "input: Ctrl+Y (25)" {
    const p = input.parseKey(&.{25}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'y' }, p.key);
}
test "input: Ctrl+Z (26)" {
    const p = input.parseKey(&.{26}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'z' }, p.key);
}

// ═══════════════════════════════════════════════════
//  parseKey — EP: özel tuşlar
// ═══════════════════════════════════════════════════
test "input: enter (LF)" {
    const p = input.parseKey(&.{10}).?;
    try std.testing.expectEqual(types.Key.enter, p.key);
}
test "input: enter (CR)" {
    const p = input.parseKey(&.{13}).?;
    try std.testing.expectEqual(types.Key.enter, p.key);
}
test "input: backspace" {
    const p = input.parseKey(&.{127}).?;
    try std.testing.expectEqual(types.Key.backspace, p.key);
}
test "input: tab" {
    const p = input.parseKey(&.{9}).?;
    try std.testing.expectEqual(types.Key.tab, p.key);
}
test "input: space" {
    const p = input.parseKey(&.{32}).?;
    try std.testing.expectEqual(types.Key{ .char = ' ' }, p.key);
}
test "input: printable 'a'" {
    const p = input.parseKey("a").?;
    try std.testing.expectEqual(types.Key{ .char = 'a' }, p.key);
}
test "input: tilde ~" {
    const p = input.parseKey(&.{126}).?;
    try std.testing.expectEqual(types.Key{ .char = '~' }, p.key);
}

// ═══════════════════════════════════════════════════
//  parseKey — EP: escape sekansları
// ═══════════════════════════════════════════════════
test "input: arrow up" {
    const p = input.parseKey("\x1b[A").?;
    try std.testing.expectEqual(types.Key.arrow_up, p.key);
    try std.testing.expectEqual(@as(usize, 3), p.consumed);
}
test "input: arrow down" {
    const p = input.parseKey("\x1b[B").?;
    try std.testing.expectEqual(types.Key.arrow_down, p.key);
}
test "input: arrow right" {
    const p = input.parseKey("\x1b[C").?;
    try std.testing.expectEqual(types.Key.arrow_right, p.key);
}
test "input: arrow left" {
    const p = input.parseKey("\x1b[D").?;
    try std.testing.expectEqual(types.Key.arrow_left, p.key);
}
test "input: home (CSI H)" {
    const p = input.parseKey("\x1b[H").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}
test "input: end (CSI F)" {
    const p = input.parseKey("\x1b[F").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}
test "input: delete (CSI 3~)" {
    const p = input.parseKey("\x1b[3~").?;
    try std.testing.expectEqual(types.Key.delete, p.key);
}
test "input: page up" {
    const p = input.parseKey("\x1b[5~").?;
    try std.testing.expectEqual(types.Key.page_up, p.key);
}
test "input: page down" {
    const p = input.parseKey("\x1b[6~").?;
    try std.testing.expectEqual(types.Key.page_down, p.key);
}
test "input: home (CSI 1~)" {
    const p = input.parseKey("\x1b[1~").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}
test "input: end (CSI 4~)" {
    const p = input.parseKey("\x1b[4~").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}
test "input: home (CSI 7~)" {
    const p = input.parseKey("\x1b[7~").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}
test "input: end (CSI 8~)" {
    const p = input.parseKey("\x1b[8~").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}
test "input: SS3 home" {
    const p = input.parseKey("\x1bOH").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}
test "input: SS3 end" {
    const p = input.parseKey("\x1bOF").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}

// ═══════════════════════════════════════════════════
//  parseKey — Edge: bilinen eksiklikler
// ═══════════════════════════════════════════════════
test "input: Ctrl-Left tanınmaz (eksik)" {
    const p = input.parseKey("\x1b[1;5D").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}
test "input: Ctrl-Right tanınmaz (eksik)" {
    const p = input.parseKey("\x1b[1;5C").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}
test "input: Ctrl-Home tanınmaz (eksik)" {
    const p = input.parseKey("\x1b[1;5H").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}

// ═══════════════════════════════════════════════════
//  parseKey — Edge: sınırlar
// ═══════════════════════════════════════════════════
test "input: boş input null" {
    try std.testing.expect(input.parseKey("") == null);
}
test "input: bare escape" {
    const p = input.parseKey("\x1b").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}
test "input: bilinmeyen CSI" {
    const p = input.parseKey("\x1b[Z").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}
test "input: bilinmeyen SS3" {
    const p = input.parseKey("\x1bOZ").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}
test "input: bilinmeyen CSI ~" {
    const p = input.parseKey("\x1b[9~").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}
test "input: byte 0" {
    const p = input.parseKey(&.{0}).?;
    try std.testing.expectEqual(types.Key{ .char = 0 }, p.key);
}
test "input: byte 255" {
    const p = input.parseKey(&.{255}).?;
    try std.testing.expectEqual(types.Key{ .char = 255 }, p.key);
}
test "input: byte 31 (control)" {
    const p = input.parseKey(&.{31}).?;
    try std.testing.expectEqual(types.Key{ .char = 31 }, p.key);
}

// ═══════════════════════════════════════════════════
//  Clipboard — EP + Edge
// ═══════════════════════════════════════════════════
test "clipboard: boş get" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try std.testing.expectEqualStrings("", cb.get());
}
test "clipboard: set/get" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("hello");
    try std.testing.expectEqualStrings("hello", cb.get());
}
test "clipboard: overwrite" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("first");
    try cb.set("second");
    try std.testing.expectEqualStrings("second", cb.get());
}
test "clipboard: boş set" {
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set("something");
    try cb.set("");
    try std.testing.expectEqualStrings("", cb.get());
}
test "clipboard: osc52 boş text" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\x07"));
}
test "clipboard: osc52 unicode" {
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, "türkçe");
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\x1b]52;c;"));
}
