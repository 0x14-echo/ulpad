const std = @import("std");
const ulpad = @import("ulpad");
const PieceTable = ulpad.PieceTable;
const LineIndex = ulpad.LineIndex;
const Document = ulpad.Document;
const search = ulpad.search;

pub const A = std.testing.allocator;

pub fn tableText(table: *const PieceTable) ![]u8 {
    return table.toOwnedSlice(A);
}

pub fn expectTable(table: *const PieceTable, expected: []const u8) !void {
    const text = try tableText(table);
    defer A.free(text);
    try std.testing.expectEqualStrings(expected, text);
}

pub fn checkTable(table: *const PieceTable) !void {
    const text = try tableText(table);
    defer A.free(text);
    try std.testing.expectEqual(text.len, table.byteLen());
}

pub fn docText(doc: *const Document) ![]u8 {
    return doc.textAlloc(A);
}

pub fn expectDoc(doc: *const Document, expected: []const u8) !void {
    const text = try docText(doc);
    defer A.free(text);
    try std.testing.expectEqualStrings(expected, text);
}

pub fn checkLineIndex(text: []const u8, idx: *const LineIndex) !void {
    var expected_count: usize = 1;
    for (text) |b| {
        if (b == '\n') expected_count += 1;
    }
    try std.testing.expectEqual(expected_count, idx.lineCount());

    var line: usize = 0;
    try std.testing.expectEqual(@as(usize, 0), idx.lineStart(0));
    for (text, 0..) |b, i| {
        const got_line = idx.lineOfOffset(i);
        try std.testing.expect(got_line <= line);
        if (b == '\n') {
            try std.testing.expectEqual(line, got_line);
            line += 1;
            if (line < idx.lineCount()) {
                try std.testing.expectEqual(i + 1, idx.lineStart(line));
            }
        }
    }
}

pub fn checkDoc(doc: *const Document) !void {
    const text = try docText(doc);
    defer A.free(text);

    try std.testing.expectEqual(text.len, doc.byteLen());

    var expected_lines: usize = 1;
    for (text) |b| {
        if (b == '\n') expected_lines += 1;
    }
    try std.testing.expectEqual(expected_lines, doc.lineCount());

    var idx = LineIndex.init(A);
    defer idx.deinit();
    try idx.rebuild(text);
    try checkLineIndex(text, &idx);

    for (0..doc.lineCount()) |line| {
        try std.testing.expectEqual(idx.lineStart(line), doc.lineStart(line));
        try std.testing.expectEqual(idx.lineEnd(line, text.len), doc.lineEnd(line));
        try std.testing.expectEqual(idx.lineContentEnd(line, text.len), doc.lineContentEnd(line));
    }
}

pub fn expectFind(
    doc: *const Document,
    needle: []const u8,
    from: usize,
    direction: search.Direction,
    start: usize,
    end: usize,
) !void {
    const match = (try search.find(doc, needle, from, direction)).?;
    try std.testing.expectEqual(start, match.start);
    try std.testing.expectEqual(end, match.end);
}

pub fn expectNoFind(
    doc: *const Document,
    needle: []const u8,
    from: usize,
    direction: search.Direction,
) !void {
    try std.testing.expect(null == try search.find(doc, needle, from, direction));
}
