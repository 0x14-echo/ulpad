const std = @import("std");
const ulpad = @import("ulpad");
const D = ulpad.Document;
const S = ulpad.search;
const A = std.testing.allocator;

fn mk(t: []const u8) !D {
    return D.initCopy(A, t);
}
fn txt(doc: *D) ![]u8 {
    return doc.textAlloc(A);
}

// ═══════════════════════════════════════════════════
//  find — BVA: from parametresi
// ═══════════════════════════════════════════════════
test "find: from=0 forward ilk eşleşmeyi bulur" {
    var d = try mk("abc def abc");
    defer d.deinit();
    const m = (try S.find(&d, "abc", 0, .forward)).?;
    try std.testing.expectEqual(@as(usize, 0), m.start);
}
test "find: from=doc.len forward null" {
    var d = try mk("abc");
    defer d.deinit();
    try std.testing.expect(null == try S.find(&d, "abc", 3, .forward));
}
test "find: from>doc.len backward clamp ve bulur" {
    var d = try mk("abc");
    defer d.deinit();
    const m = (try S.find(&d, "abc", 999, .backward)).?;
    try std.testing.expectEqual(@as(usize, 0), m.start);
}
test "find: from=0 backward match bulur" {
    var d = try mk("abc def");
    defer d.deinit();
    const m = (try S.find(&d, "abc", 0, .backward)).?;
    try std.testing.expectEqual(@as(usize, 0), m.start);
}

// ═══════════════════════════════════════════════════
//  find — EP: girdi sınıfları
// ═══════════════════════════════════════════════════
test "find: boş needle null" {
    var d = try mk("abc");
    defer d.deinit();
    try std.testing.expect(null == try S.find(&d, "", 0, .forward));
}
test "find: boş doküman null" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    try std.testing.expect(null == try S.find(&d, "x", 0, .forward));
}
test "find: needle > doküman null" {
    var d = try mk("ab");
    defer d.deinit();
    try std.testing.expect(null == try S.find(&d, "abcdef", 0, .forward));
}
test "find: needle == doküman" {
    var d = try mk("exact");
    defer d.deinit();
    const m = (try S.find(&d, "exact", 0, .forward)).?;
    try std.testing.expectEqual(@as(usize, 0), m.start);
    try std.testing.expectEqual(@as(usize, 5), m.end);
}
test "find: tek karakter doküman ve needle" {
    var d = try mk("x");
    defer d.deinit();
    const m = (try S.find(&d, "x", 0, .forward)).?;
    try std.testing.expectEqual(@as(usize, 0), m.start);
}

// ═══════════════════════════════════════════════════
//  find — Edge: overlapping, çoklu
// ═══════════════════════════════════════════════════
test "find: overlapping ilkini bulur" {
    var d = try mk("aaaa");
    defer d.deinit();
    const m = (try S.find(&d, "aa", 0, .forward)).?;
    try std.testing.expectEqual(@as(usize, 0), m.start);
}
test "find: overlapping 2. pozisyondan" {
    var d = try mk("aaaa");
    defer d.deinit();
    const m = (try S.find(&d, "aa", 1, .forward)).?;
    try std.testing.expectEqual(@as(usize, 1), m.start);
}
test "find: ardışık forward tüm eşleşmeleri bulur" {
    var d = try mk("cat dog cat bird cat");
    defer d.deinit();
    var cur: usize = 0;
    var n: usize = 0;
    while (try S.find(&d, "cat", cur, .forward)) |m| {
        n += 1;
        cur = m.end;
    }
    try std.testing.expectEqual(@as(usize, 3), n);
}
test "find: backward sonda bulur" {
    var d = try mk("abc def abc");
    defer d.deinit();
    const m = (try S.find(&d, "abc", 11, .backward)).?;
    try std.testing.expectEqual(@as(usize, 8), m.start);
}
test "find: çok satırlı dokümanda" {
    var d = try mk("hello\nworld\ntest");
    defer d.deinit();
    const m = (try S.find(&d, "world", 0, .forward)).?;
    try std.testing.expectEqual(@as(usize, 6), m.start);
}
test "find: from exact match pozisyonunda" {
    var d = try mk("abcabc");
    defer d.deinit();
    const m = (try S.find(&d, "abc", 3, .forward)).?;
    try std.testing.expectEqual(@as(usize, 3), m.start);
}

// ═══════════════════════════════════════════════════
//  replaceAll — Edge
// ═══════════════════════════════════════════════════
test "replaceAll: boş needle → 0" {
    var d = try mk("abc");
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 0), try S.replaceAll(&d, "", "x"));
}
test "replaceAll: needle==replacement sonsuz döngü yok" {
    var d = try mk("aaa");
    defer d.deinit();
    const n = try S.replaceAll(&d, "a", "a");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqual(@as(usize, 3), n);
    try std.testing.expectEqualStrings("aaa", t);
}
test "replaceAll: boş replacement siler" {
    var d = try mk("aXbXc");
    defer d.deinit();
    _ = try S.replaceAll(&d, "X", "");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqualStrings("abc", t);
}
test "replaceAll: longer replacement büyütür" {
    var d = try mk("a b c");
    defer d.deinit();
    _ = try S.replaceAll(&d, " ", "___");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqualStrings("a___b___c", t);
}
test "replaceAll: shorter replacement daraltır" {
    var d = try mk("aaaaaa");
    defer d.deinit();
    _ = try S.replaceAll(&d, "aa", "b");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqualStrings("bbb", t);
}
test "replaceAll: match yok → değişiklik yok" {
    var d = try mk("hello world");
    defer d.deinit();
    const n = try S.replaceAll(&d, "xyz", "abc");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqual(@as(usize, 0), n);
    try std.testing.expectEqualStrings("hello world", t);
}
test "replaceAll: ardışık döngü tutarlı" {
    var d = try mk("v1.0.0");
    defer d.deinit();
    _ = try S.replaceAll(&d, "v1", "v2");
    _ = try S.replaceAll(&d, "v2.0", "v3.1");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqualStrings("v3.1.0", t);
}
test "replaceAll: replacement needle içinde" {
    var d = try mk("abcabcabc");
    defer d.deinit();
    _ = try S.replaceAll(&d, "abc", "a");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqualStrings("aaa", t);
}
test "replaceAll: needle replacement içinde" {
    var d = try mk("aaa");
    defer d.deinit();
    _ = try S.replaceAll(&d, "a", "abc");
    const t = try txt(&d);
    defer A.free(t);
    try std.testing.expectEqualStrings("abcabcabc", t);
}
test "replaceAll: 100 eşleşme stress" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    var buf: [300]u8 = undefined;
    for (0..100) |i| {
        buf[i * 3] = 'a';
        buf[i * 3 + 1] = 'b';
        buf[i * 3 + 2] = 'c';
    }
    try d.insert(0, &buf);
    const n = try S.replaceAll(&d, "abc", "X");
    try std.testing.expectEqual(@as(usize, 100), n);
    const t = try txt(&d);
    defer A.free(t);
    for (t) |b| try std.testing.expectEqual(@as(u8, 'X'), b);
}
