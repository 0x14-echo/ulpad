const std = @import("std");
const PieceTable = @import("piece_table.zig").PieceTable;
const LineIndex = @import("line_index.zig").LineIndex;

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

    pub fn deinit(self: *Document) void {
        self.lines.deinit();
        self.table.deinit();
    }

    pub fn insert(self: *Document, index: usize, bytes: []const u8) !void {
        try self.table.insert(index, bytes);
        try self.rebuildLineIndex();
    }

    pub fn textAlloc(self: *const Document, allocator: std.mem.Allocator) ![]u8 {
        return self.table.toOwnedSlice(allocator);
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
