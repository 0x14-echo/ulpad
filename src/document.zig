const std = @import("std");
const PieceTable = @import("piece_table.zig").PieceTable;
const LineIndex = @import("line_index.zig").LineIndex;
const Match = @import("piece_table.zig").PieceTable.Match;

pub const Document = struct {
    allocator: std.mem.Allocator,
    table: PieceTable,
    lines: LineIndex,

    pub fn initEmpty(allocator: std.mem.Allocator) !Document {
        var lines = LineIndex.init(allocator);
        try lines.rebuild("");
        return .{
            .allocator = allocator,
            .table = PieceTable.initEmpty(allocator),
            .lines = lines,
        };
    }

    pub fn initCopy(allocator: std.mem.Allocator, text: []const u8) !Document {
        var lines = LineIndex.init(allocator);
        errdefer lines.deinit();
        try lines.rebuild(text);
        return .{
            .allocator = allocator,
            .table = try PieceTable.initCopy(allocator, text),
            .lines = lines,
        };
    }

    pub fn deinit(self: *Document) void {
        self.lines.deinit();
        self.table.deinit();
    }

    pub fn insert(self: *Document, index: usize, bytes: []const u8) !void {
        try self.table.insert(index, bytes);
        try self.rebuildLineIndex();
    }

    pub fn delete(self: *Document, start: usize, end: usize) !void {
        try self.table.delete(start, end);
        try self.rebuildLineIndex();
    }

    pub fn replaceRange(self: *Document, start: usize, end: usize, bytes: []const u8) !void {
        try self.table.delete(start, end);
        try self.table.insert(start, bytes);
        try self.rebuildLineIndex();
    }

    pub fn textAlloc(self: *const Document, allocator: std.mem.Allocator) ![]u8 {
        return self.table.toOwnedSlice(allocator);
    }

    pub fn sliceAlloc(self: *const Document, allocator: std.mem.Allocator, start: usize, end: usize) ![]u8 {
        return self.table.copyRangeAlloc(allocator, start, end);
    }

    pub fn lineCount(self: *const Document) usize {
        return self.lines.lineCount();
    }

    pub fn byteLen(self: *const Document) usize {
        return self.table.byteLen();
    }

    pub fn lineOfOffset(self: *const Document, offset: usize) usize {
        return self.lines.lineOfOffset(offset);
    }

    pub fn lineStart(self: *const Document, line: usize) ?usize {
        return self.lines.lineStart(line);
    }

    pub fn lineEnd(self: *const Document, line: usize) usize {
        return self.lines.lineEnd(line, self.byteLen());
    }

    pub fn lineContentEnd(self: *const Document, line: usize) usize {
        return self.lines.lineContentEnd(line, self.byteLen());
    }

    fn rebuildLineIndex(self: *Document) !void {
        const text = try self.table.toOwnedSlice(self.allocator);
        defer self.allocator.free(text);
        try self.lines.rebuild(text);
    }
};

test "insert updates line index" {
    var doc = try Document.initEmpty(std.testing.allocator);
    defer doc.deinit();

    try doc.insert(0, "hello\nworld");

    const actual = try doc.textAlloc(std.testing.allocator);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqualStrings("hello\nworld", actual);
    try std.testing.expectEqual(@as(usize, 2), doc.lines.lineCount());
    try std.testing.expectEqual(@as(usize, 1), doc.lines.lineOfOffset(6));
}

test "delete updates text and line count" {
    var doc = try Document.initEmpty(std.testing.allocator);
    defer doc.deinit();

    try doc.insert(0, "alpha\nbeta\ngamma");
    try doc.delete(5, 11);

    const actual = try doc.textAlloc(std.testing.allocator);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqualStrings("alphagamma", actual);
    try std.testing.expectEqual(@as(usize, 1), doc.lineCount());
}
