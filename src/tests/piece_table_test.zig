const std = @import("std");
const PT = @import("ulpad").PieceTable;

const A = std.testing.allocator;
fn s(table: *PT) ![]u8 {
    return table.toOwnedSlice(A);
}

// ═══════════════════════════════════════════════════
//  initCopy
// ═══════════════════════════════════════════════════
test "initCopy: boş string → len=0" {
    var t = try PT.initCopy(A, "");
    defer t.deinit();
    try std.testing.expectEqual(@as(usize, 0), t.byteLen());
}
test "initCopy: tek byte → len=1" {
    var t = try PT.initCopy(A, "x");
    defer t.deinit();
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("x", v);
}
test "initCopy: 1000 byte doğru kopyalanır" {
    var buf: [1000]u8 = undefined;
    for (&buf, 0..) |*b, i| b.* = @intCast(i % 256);
    var t = try PT.initCopy(A, &buf);
    defer t.deinit();
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqual(@as(usize, 1000), t.byteLen());
    try std.testing.expect(std.mem.eql(u8, &buf, v));
}

// ═══════════════════════════════════════════════════
//  insert — BVA
// ═══════════════════════════════════════════════════
test "insert: index=0 başa ekler" {
    var t = try PT.initCopy(A, "bc");
    defer t.deinit();
    try t.insert(0, "a");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abc", v);
}
test "insert: index=len sona ekler" {
    var t = try PT.initCopy(A, "ab");
    defer t.deinit();
    try t.insert(2, "c");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abc", v);
}
test "insert: index=len+1 hata" {
    var t = try PT.initCopy(A, "ab");
    defer t.deinit();
    try std.testing.expectError(error.IndexOutOfBounds, t.insert(3, "x"));
}
test "insert: index=len+100 hata" {
    var t = try PT.initCopy(A, "a");
    defer t.deinit();
    try std.testing.expectError(error.IndexOutOfBounds, t.insert(101, "x"));
}
test "insert: boş bytes no-op" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try t.insert(1, "");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abc", v);
}
test "insert: boş tabloya ekleme" {
    var t = PT.initEmpty(A);
    defer t.deinit();
    try t.insert(0, "hello");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("hello", v);
}

// ═══════════════════════════════════════════════════
//  insert — parça sınırları
// ═══════════════════════════════════════════════════
test "insert: parça ortasında split" {
    var t = try PT.initCopy(A, "abcdef");
    defer t.deinit();
    try t.insert(3, "XXX");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abcXXXdef", v);
}
test "insert: parça başında" {
    var t = try PT.initCopy(A, "hello");
    defer t.deinit();
    try t.insert(0, ">>> ");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings(">>> hello", v);
}
test "insert: parça sonunda" {
    var t = try PT.initCopy(A, "hello");
    defer t.deinit();
    try t.insert(5, " <<<");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("hello <<<", v);
}
test "insert: ardışık ekleme normalize" {
    var t = PT.initEmpty(A);
    defer t.deinit();
    try t.insert(0, "ab");
    try t.insert(2, "cd");
    try t.insert(4, "ef");
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abcdef", v);
}
test "insert: 10 ardışık ekleme" {
    var t = PT.initEmpty(A);
    defer t.deinit();
    for (0..10) |i| {
        const c: u8 = @intCast('a' + i);
        try t.insert(i, &[_]u8{c});
    }
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abcdefghij", v);
}

// ═══════════════════════════════════════════════════
//  delete — BVA
// ═══════════════════════════════════════════════════
test "delete: start=0 end=len tümünü siler" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try t.delete(0, 3);
    try std.testing.expectEqual(@as(usize, 0), t.byteLen());
}
test "delete: start==end no-op" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try t.delete(1, 1);
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abc", v);
}
test "delete: start>end hata" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try std.testing.expectError(error.IndexOutOfBounds, t.delete(2, 1));
}
test "delete: end>len hata" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try std.testing.expectError(error.IndexOutOfBounds, t.delete(0, 100));
}
test "delete: tek karakter silme (ilk)" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try t.delete(0, 1);
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("bc", v);
}
test "delete: tek karakter silme (son)" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try t.delete(2, 3);
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("ab", v);
}
test "delete: tek karakter silme (orta)" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try t.delete(1, 2);
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("ac", v);
}
test "delete: tek byte dokümandan" {
    var t = try PT.initCopy(A, "x");
    defer t.deinit();
    try t.delete(0, 1);
    try std.testing.expectEqual(@as(usize, 0), t.byteLen());
}

// ═══════════════════════════════════════════════════
//  delete — parça sınırları
// ═══════════════════════════════════════════════════
test "delete: parça ortasından" {
    var t = try PT.initCopy(A, "abcdef");
    defer t.deinit();
    try t.delete(2, 4);
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abef", v);
}
test "delete: add buffer parçasını tamamen siler" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try t.insert(1, "INSERTED");
    try t.delete(1, 9);
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("abc", v);
}
test "delete: çoklu parça oluşturup hepsini sil" {
    var t = PT.initEmpty(A);
    defer t.deinit();
    try t.insert(0, "aaaa");
    try t.insert(4, "bbbb");
    try t.insert(8, "cccc");
    try t.delete(0, 12);
    try std.testing.expectEqual(@as(usize, 0), t.byteLen());
}

// ═══════════════════════════════════════════════════
//  copyRangeAlloc — BVA + Edge
// ═══════════════════════════════════════════════════
test "copyRange: ilk byte" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    const v = try t.copyRangeAlloc(A, 0, 1);
    defer A.free(v);
    try std.testing.expectEqualStrings("a", v);
}
test "copyRange: son byte" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    const v = try t.copyRangeAlloc(A, 2, 3);
    defer A.free(v);
    try std.testing.expectEqualStrings("c", v);
}
test "copyRange: orta" {
    var t = try PT.initCopy(A, "abcdef");
    defer t.deinit();
    const v = try t.copyRangeAlloc(A, 2, 5);
    defer A.free(v);
    try std.testing.expectEqualStrings("cde", v);
}
test "copyRange: boş aralık" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    const v = try t.copyRangeAlloc(A, 1, 1);
    defer A.free(v);
    try std.testing.expectEqualStrings("", v);
}
test "copyRange: out of bounds hata" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try std.testing.expectError(error.IndexOutOfBounds, t.copyRangeAlloc(A, 0, 100));
}
test "copyRange: start>end hata" {
    var t = try PT.initCopy(A, "abc");
    defer t.deinit();
    try std.testing.expectError(error.IndexOutOfBounds, t.copyRangeAlloc(A, 2, 1));
}
test "copyRange: parça sınırlarını aşar" {
    var t = try PT.initCopy(A, "01234");
    defer t.deinit();
    try t.insert(2, "AB");
    const v = try t.copyRangeAlloc(A, 1, 5);
    defer A.free(v);
    try std.testing.expectEqualStrings("1AB2", v);
}

// ═══════════════════════════════════════════════════
//  Insert-Delete cycle
// ═══════════════════════════════════════════════════
test "cycle: insert-delete-insert-delete" {
    var t = PT.initEmpty(A);
    defer t.deinit();
    try t.insert(0, "AAAA");
    try t.delete(1, 3);
    try t.insert(1, "BB");
    try t.delete(2, 3);
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expectEqualStrings("ABA", v);
}
test "cycle: 50 kez insert-delete" {
    var t = PT.initEmpty(A);
    defer t.deinit();
    for (0..50) |i| {
        const c: u8 = @intCast((i % 26) + 'a');
        try t.insert(t.byteLen(), &[_]u8{c});
        if (t.byteLen() > 5) try t.delete(0, 1);
    }
    const v = try s(&t);
    defer A.free(v);
    try std.testing.expect(v.len > 0);
}
