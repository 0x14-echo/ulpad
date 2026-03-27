const std = @import("std");

pub const PieceTable = struct {
    const Source = enum {
        original,
        add,
    };

    const Piece = struct {
        source: Source,
        start: usize,
        len: usize,
    };

    allocator: std.mem.Allocator,
    original: []u8,
    add: std.ArrayList(u8),
    pieces: std.ArrayList(Piece),
    len: usize,

    pub fn initEmpty(allocator: std.mem.Allocator) PieceTable {
        return .{
            .allocator = allocator,
            .original = &.{},
            .add = .empty,
            .pieces = .empty,
            .len = 0,
        };
    }

    pub fn initCopy(allocator: std.mem.Allocator, text: []const u8) !PieceTable {
        var table = PieceTable.initEmpty(allocator);
        errdefer table.deinit();

        table.original = try allocator.dupe(u8, text);
        if (text.len != 0) {
            try table.pieces.append(allocator, .{
                .source = .original,
                .start = 0,
                .len = text.len,
            });
            table.len = text.len;
        }
        return table;
    }

    pub fn deinit(self: *PieceTable) void {
        self.allocator.free(self.original);
        self.add.deinit(self.allocator);
        self.pieces.deinit(self.allocator);
    }

    pub fn insert(self: *PieceTable, index: usize, bytes: []const u8) !void {
        if (index > self.len) return error.IndexOutOfBounds;
        if (bytes.len == 0) return;

        const add_start = self.add.items.len;
        try self.add.appendSlice(self.allocator, bytes);

        const new_piece: Piece = .{
            .source = .add,
            .start = add_start,
            .len = bytes.len,
        };

        if (self.pieces.items.len == 0) {
            try self.pieces.append(self.allocator, new_piece);
            self.len += bytes.len;
            return;
        }

        var logical_offset: usize = 0;
        for (self.pieces.items, 0..) |piece, piece_index| {
            const piece_end = logical_offset + piece.len;
            if (index <= piece_end) {
                const within_piece = index - logical_offset;
                if (within_piece == 0) {
                    try self.pieces.insert(self.allocator, piece_index, new_piece);
                } else if (within_piece == piece.len) {
                    try self.pieces.insert(self.allocator, piece_index + 1, new_piece);
                } else {
                    self.pieces.items[piece_index].len = within_piece;
                    const right_piece: Piece = .{
                        .source = piece.source,
                        .start = piece.start + within_piece,
                        .len = piece.len - within_piece,
                    };
                    try self.pieces.insert(self.allocator, piece_index + 1, new_piece);
                    try self.pieces.insert(self.allocator, piece_index + 2, right_piece);
                }
                self.len += bytes.len;
                self.normalizePieces();
                return;
            }
            logical_offset = piece_end;
        }

        try self.pieces.append(self.allocator, new_piece);
        self.len += bytes.len;
        self.normalizePieces();
    }

    pub fn delete(self: *PieceTable, start: usize, end: usize) !void {
        if (start > end or start > self.len or end > self.len) return error.IndexOutOfBounds;
        if (start == end) return;

        var next_pieces: std.ArrayList(Piece) = .empty;
        errdefer next_pieces.deinit(self.allocator);

        var logical_offset: usize = 0;
        for (self.pieces.items) |piece| {
            const piece_start = logical_offset;
            const piece_end = logical_offset + piece.len;

            if (end <= piece_start or start >= piece_end) {
                try next_pieces.append(self.allocator, piece);
            } else {
                if (start > piece_start) {
                    try next_pieces.append(self.allocator, .{
                        .source = piece.source,
                        .start = piece.start,
                        .len = start - piece_start,
                    });
                }

                if (end < piece_end) {
                    try next_pieces.append(self.allocator, .{
                        .source = piece.source,
                        .start = piece.start + (end - piece_start),
                        .len = piece_end - end,
                    });
                }
            }

            logical_offset = piece_end;
        }

        self.pieces.deinit(self.allocator);
        self.pieces = next_pieces;
        self.len -= end - start;
        self.normalizePieces();
    }

    pub fn byteLen(self: *const PieceTable) usize {
        return self.len;
    }

    pub fn copyRangeAlloc(
        self: *const PieceTable,
        allocator: std.mem.Allocator,
        start: usize,
        end: usize,
    ) ![]u8 {
        if (start > end or start > self.len or end > self.len) return error.IndexOutOfBounds;

        var out = try allocator.alloc(u8, end - start);
        var out_index: usize = 0;
        var logical_offset: usize = 0;

        for (self.pieces.items) |piece| {
            const piece_start = logical_offset;
            const piece_end = logical_offset + piece.len;
            if (end <= piece_start or start >= piece_end) {
                logical_offset = piece_end;
                continue;
            }

            const overlap_start = @max(start, piece_start);
            const overlap_end = @min(end, piece_end);
            const source = self.sourceSlice(piece) orelse return error.InvalidSlice;
            const relative_start = overlap_start - piece_start;
            const relative_end = overlap_end - piece_start;
            const chunk = source[relative_start..relative_end];
            @memcpy(out[out_index .. out_index + chunk.len], chunk);
            out_index += chunk.len;
            logical_offset = piece_end;
        }

        return out;
    }

    pub fn toOwnedSlice(self: *const PieceTable, allocator: std.mem.Allocator) ![]u8 {
        var out = try allocator.alloc(u8, self.len);
        var out_index: usize = 0;
        for (self.pieces.items) |piece| {
            const source = self.sourceSlice(piece) orelse return error.InvalidSlice;
            @memcpy(out[out_index .. out_index + source.len], source);
            out_index += source.len;
        }
        return out;
    }

    fn sourceSlice(self: *const PieceTable, piece: Piece) ?[]const u8 {
        const source = switch (piece.source) {
            .original => self.original,
            .add => self.add.items,
        };
        const end = piece.start + piece.len;
        if (piece.start >= source.len or end > source.len) return null;
        return source[piece.start..end];
    }

    fn normalizePieces(self: *PieceTable) void {
        if (self.pieces.items.len < 2) return;

        var write_index: usize = 0;
        for (self.pieces.items) |piece| {
            if (piece.len == 0) continue;
            if (write_index == 0) {
                self.pieces.items[0] = piece;
                write_index = 1;
                continue;
            }

            var prev = &self.pieces.items[write_index - 1];
            if (prev.source == piece.source and prev.start + prev.len == piece.start) {
                prev.len += piece.len;
            } else {
                self.pieces.items[write_index] = piece;
                write_index += 1;
            }
        }
        self.pieces.items.len = write_index;
    }

    pub const Match = struct { start: usize, end: usize };

    pub fn iterate(self: *const PieceTable, from: usize, needle: []const u8, forward: bool) ?Match {
        if (needle.len == 0 or self.len == 0) return null;
        if (from > self.len) return null;

        const search_start: usize = if (forward) from else 0;
        const search_end: usize = if (forward) self.len else if (from >= needle.len) from - needle.len + 1 else 0;

        var pos: usize = search_start;
        const max_chunk: usize = 4096;

        while (pos < search_end) {
            const remaining = search_end - pos;
            const to_read = @min(remaining, max_chunk);
            const chunk = self.readChunk(pos, to_read) orelse break;

            var search_pos: usize = 0;
            while (search_pos < chunk.len) {
                if (chunk.len - search_pos < needle.len) break;
                if (chunk[search_pos] == needle[0]) {
                    var match = true;
                    for (needle, 1..) |c, i| {
                        if (chunk[search_pos + i] != c) {
                            match = false;
                            break;
                        }
                    }
                    if (match) {
                        const absolute_pos = pos + search_pos;
                        return .{ .start = absolute_pos, .end = absolute_pos + needle.len };
                    }
                }
                search_pos += 1;
            }

            pos += to_read;
        }

        return null;
    }

    fn readChunk(self: *const PieceTable, offset: usize, max_len: usize) ?[]u8 {
        var result: usize = 0;
        var logical_offset: usize = 0;
        var buffer: [4096]u8 = undefined;

        for (self.pieces.items) |piece| {
            const piece_start = logical_offset;
            const piece_end = logical_offset + piece.len;

            if (offset >= piece_start and offset < piece_end) {
                const source = self.sourceSlice(piece) orelse return null;
                const start_in_piece = offset - piece_start;
                const available = piece.len - start_in_piece;
                const to_copy = @min(@min(available, max_len - result), buffer.len - result);
                @memcpy(buffer[result .. result + to_copy], source[start_in_piece .. start_in_piece + to_copy]);
                result += to_copy;
                if (result >= max_len or result >= buffer.len) break;
            }

            logical_offset = piece_end;
        }

        if (result == 0) return null;
        return buffer[0..result];
    }
};

test "init copy preserves the original text" {
    var table = try PieceTable.initCopy(std.testing.allocator, "hello");
    defer table.deinit();

    const actual = try table.toOwnedSlice(std.testing.allocator);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqual(@as(usize, 5), table.byteLen());
    try std.testing.expectEqualStrings("hello", actual);
}

test "insert places text at the requested offset" {
    var table = PieceTable.initEmpty(std.testing.allocator);
    defer table.deinit();

    try table.insert(0, "abc");
    try table.insert(1, "Z");

    const actual = try table.toOwnedSlice(std.testing.allocator);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqualStrings("aZbc", actual);
}

test "delete removes bytes across piece boundaries" {
    var table = try PieceTable.initCopy(std.testing.allocator, "hello world");
    defer table.deinit();

    try table.insert(5, ", brave new");
    try table.delete(5, 16);

    const actual = try table.toOwnedSlice(std.testing.allocator);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqualStrings("hello world", actual);
}

test "copy range returns the requested bytes" {
    var table = try PieceTable.initCopy(std.testing.allocator, "0123456789");
    defer table.deinit();

    try table.insert(5, "abc");

    const actual = try table.copyRangeAlloc(std.testing.allocator, 3, 9);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqualStrings("34abc5", actual);
}
