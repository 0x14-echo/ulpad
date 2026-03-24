const std = @import("std");
const ulpad = @import("ulpad");
const D = ulpad.Document;
const S = ulpad.search;

const A = std.testing.allocator;

fn txt(doc: *const D) ![]u8 {
    return doc.textAlloc(A);
}
fn expect(doc: *const D, exp: []const u8) !void {
    const t = try txt(doc);
    defer A.free(t);
    try std.testing.expectEqualStrings(exp, t);
}
fn check(doc: *const D) !void {
    const t = try txt(doc);
    defer A.free(t);
    try std.testing.expectEqual(t.len, doc.byteLen());
    var n: usize = 1;
    for (t) |b| {
        if (b == '\n') n += 1;
    }
    try std.testing.expectEqual(n, doc.lineCount());
}

// ═══════════════════════════════════════════════════
//  init
// ═══════════════════════════════════════════════════
test "init: boş doküman" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 0), d.byteLen());
    try std.testing.expectEqual(@as(usize, 1), d.lineCount());
}
test "init: kopyalama" {
    var d = try D.initCopy(A, "hello");
    defer d.deinit();
    try expect(&d, "hello");
}

// ═══════════════════════════════════════════════════
//  insert — BVA
// ═══════════════════════════════════════════════════
test "insert: başa" {
    var d = try D.initCopy(A, "bc");
    defer d.deinit();
    try d.insert(0, "a");
    try expect(&d, "abc");
    try check(&d);
}
test "insert: sona" {
    var d = try D.initCopy(A, "ab");
    defer d.deinit();
    try d.insert(2, "c");
    try expect(&d, "abc");
    try check(&d);
}
test "insert: ortaya" {
    var d = try D.initCopy(A, "ac");
    defer d.deinit();
    try d.insert(1, "b");
    try expect(&d, "abc");
    try check(&d);
}
test "insert: newline başa → 2 satır" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try d.insert(0, "\n");
    try expect(&d, "\nabc");
    try std.testing.expectEqual(@as(usize, 2), d.lineCount());
}
test "insert: newline sona → 2 satır" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try d.insert(3, "\n");
    try expect(&d, "abc\n");
    try std.testing.expectEqual(@as(usize, 2), d.lineCount());
}
test "insert: newline ortaya → satır bölünür" {
    var d = try D.initCopy(A, "hello world");
    defer d.deinit();
    try d.insert(5, "\n");
    try expect(&d, "hello\n world");
    try std.testing.expectEqual(@as(usize, 2), d.lineCount());
}
test "insert: 3 newline → 4 satır" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    try d.insert(0, "\n\n\n");
    try std.testing.expectEqual(@as(usize, 4), d.lineCount());
}

// ═══════════════════════════════════════════════════
//  delete — BVA
// ═══════════════════════════════════════════════════
test "delete: ilk karakter" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try d.delete(0, 1);
    try expect(&d, "bc");
    try check(&d);
}
test "delete: son karakter" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try d.delete(2, 3);
    try expect(&d, "ab");
    try check(&d);
}
test "delete: orta karakter" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try d.delete(1, 2);
    try expect(&d, "ac");
    try check(&d);
}
test "delete: tüm metin" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try d.delete(0, 3);
    try expect(&d, "");
    try std.testing.expectEqual(@as(usize, 1), d.lineCount());
}
test "delete: newline → satırlar birleşir" {
    var d = try D.initCopy(A, "abc\ndef");
    defer d.deinit();
    try d.delete(3, 4);
    try expect(&d, "abcdef");
    try std.testing.expectEqual(@as(usize, 1), d.lineCount());
}
test "delete: ilk satır dahil newline" {
    var d = try D.initCopy(A, "first\nsecond");
    defer d.deinit();
    try d.delete(0, 6);
    try expect(&d, "second");
    try std.testing.expectEqual(@as(usize, 1), d.lineCount());
}
test "delete: ortadaki satır" {
    var d = try D.initCopy(A, "aaa\nXXX\nbbb");
    defer d.deinit();
    try d.delete(4, 8);
    try expect(&d, "aaa\nbbb");
    try std.testing.expectEqual(@as(usize, 2), d.lineCount());
}
test "delete: son satır dahil newline" {
    var d = try D.initCopy(A, "first\nsecond\nthird");
    defer d.deinit();
    try d.delete(12, 18);
    try expect(&d, "first\nsecond");
    try std.testing.expectEqual(@as(usize, 2), d.lineCount());
}
test "delete: çoklu satır" {
    var d = try D.initCopy(A, "a\nb\nc\nd\ne");
    defer d.deinit();
    try d.delete(2, 6); // "b\nc\n"
    try std.testing.expectEqual(@as(usize, 3), d.lineCount());
}

// ═══════════════════════════════════════════════════
//  replaceRange
// ═══════════════════════════════════════════════════
test "replaceRange: boş replacement siler" {
    var d = try D.initCopy(A, "hello world");
    defer d.deinit();
    try d.replaceRange(5, 6, "");
    try expect(&d, "helloworld");
}
test "replaceRange: eşit uzunlukta replacement" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try d.replaceRange(0, 3, "xyz");
    try expect(&d, "xyz");
}
test "replaceRange: daha uzun replacement" {
    var d = try D.initCopy(A, "aXc");
    defer d.deinit();
    try d.replaceRange(1, 2, "LONGER");
    try expect(&d, "aLONGERc");
}
test "replaceRange: daha kısa replacement" {
    var d = try D.initCopy(A, "aLONGERc");
    defer d.deinit();
    try d.replaceRange(1, 7, "X");
    try expect(&d, "aXc");
}
test "replaceRange: tüm doküman" {
    var d = try D.initCopy(A, "old");
    defer d.deinit();
    try d.replaceRange(0, 3, "brand new");
    try expect(&d, "brand new");
}
test "replaceRange: baştan değiştir" {
    var d = try D.initCopy(A, "hello world");
    defer d.deinit();
    try d.replaceRange(0, 5, "HELLO");
    try expect(&d, "HELLO world");
}
test "replaceRange: sondan değiştir" {
    var d = try D.initCopy(A, "hello world");
    defer d.deinit();
    try d.replaceRange(6, 11, "WORLD");
    try expect(&d, "hello WORLD");
}

// ═══════════════════════════════════════════════════
//  lineOfOffset / lineStart / lineContentEnd
// ═══════════════════════════════════════════════════
test "lineOfOffset: offset=0 → satır 0" {
    var d = try D.initCopy(A, "abc\ndef");
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 0), d.lineOfOffset(0));
}
test "lineOfOffset: son byte → son satır" {
    var d = try D.initCopy(A, "abc\ndef");
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 1), d.lineOfOffset(6));
}
test "lineStart: satır 0 başı" {
    var d = try D.initCopy(A, "abc\ndef");
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 0), d.lineStart(0));
}
test "lineStart: satır 1 başı" {
    var d = try D.initCopy(A, "abc\ndef");
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 4), d.lineStart(1));
}
test "lineContentEnd: newline hariç" {
    var d = try D.initCopy(A, "abc\ndef");
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 3), d.lineContentEnd(0));
}
test "lineContentEnd: son satır doc sonu" {
    var d = try D.initCopy(A, "abc\ndef");
    defer d.deinit();
    try std.testing.expectEqual(@as(usize, 7), d.lineContentEnd(1));
}

// ═══════════════════════════════════════════════════
//  sliceAlloc
// ═══════════════════════════════════════════════════
test "slice: doğru aralık" {
    var d = try D.initCopy(A, "abcdef");
    defer d.deinit();
    const v = try d.sliceAlloc(A, 1, 4);
    defer A.free(v);
    try std.testing.expectEqualStrings("bcd", v);
}
test "slice: out of bounds hata" {
    var d = try D.initCopy(A, "abc");
    defer d.deinit();
    try std.testing.expectError(error.IndexOutOfBounds, d.sliceAlloc(A, 0, 100));
}

// ═══════════════════════════════════════════════════
//  Tutarlılık testleri
// ═══════════════════════════════════════════════════
test "tutarlılık: ardışık insert" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    try d.insert(0, "a");
    try check(&d);
    try d.insert(1, "b");
    try check(&d);
    try d.insert(2, "\n");
    try check(&d);
    try d.insert(3, "c");
    try check(&d);
}
test "tutarlılık: insert-delete cycle" {
    var d = try D.initEmpty(A);
    defer d.deinit();
    for (0..20) |i| {
        const c: u8 = @intCast((i % 26) + 'a');
        try d.insert(d.byteLen(), &[_]u8{c});
        try check(&d);
        if (d.byteLen() > 3) {
            try d.delete(d.byteLen() - 1, d.byteLen());
            try check(&d);
        }
    }
}
test "tutarlılık: textAlloc tutarlı" {
    var d = try D.initCopy(A, "hello\nworld");
    defer d.deinit();
    const t1 = try txt(&d);
    defer A.free(t1);
    try d.insert(5, " ");
    const t2 = try txt(&d);
    defer A.free(t2);
    try std.testing.expectEqualStrings("hello \nworld", t2);
}

// ═══════════════════════════════════════════════════
//  Search entegrasyonu
// ═══════════════════════════════════════════════════
test "search: bul → sil → tekrar bul" {
    var d = try D.initCopy(A, "abc def abc");
    defer d.deinit();
    const m1 = (try S.find(&d, "abc", 0, .forward)).?;
    try d.delete(m1.start, m1.end);
    const m2 = (try S.find(&d, "abc", 0, .forward)).?;
    try std.testing.expectEqual(@as(usize, 5), m2.start);
}
test "search: replaceAll → içerik değişir" {
    var d = try D.initCopy(A, "foo bar foo");
    defer d.deinit();
    _ = try S.replaceAll(&d, "foo", "FOO");
    try expect(&d, "FOO bar FOO");
}
