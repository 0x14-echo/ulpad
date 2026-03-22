const std = @import("std");

pub const LineIndex = struct {
    allocator: std.mem.Allocator,
    starts: std.ArrayList(usize),

    pub fn init(allocator: std.mem.Allocator) LineIndex {
        return .{
            .allocator = allocator,
            .starts = .empty,
        };
    }

    pub fn deinit(self: *LineIndex) void {
        self.starts.deinit(self.allocator);
    }

    pub fn rebuild(self: *LineIndex, bytes: []const u8) !void {
        self.starts.clearRetainingCapacity();
        try self.starts.append(self.allocator, 0);

        for (bytes, 0..) |byte, offset| {
            if (byte == '\n') {
                try self.starts.append(self.allocator, offset + 1);
            }
        }
    }

    pub fn lineCount(self: *const LineIndex) usize {
        return self.starts.items.len;
    }

    pub fn lineOfOffset(self: *const LineIndex, offset: usize) usize {
        var left: usize = 0;
        var right: usize = self.starts.items.len;
        while (left + 1 < right) {
            const mid = left + (right - left) / 2;
            if (self.starts.items[mid] <= offset) {
                left = mid;
            } else {
                right = mid;
            }
        }
        return left;
    }
};

test "rebuild tracks every line start" {
    var index = LineIndex.init(std.testing.allocator);
    defer index.deinit();

    try index.rebuild("abc\ndef\n");

    try std.testing.expectEqual(@as(usize, 3), index.lineCount());
    try std.testing.expectEqual(@as(usize, 0), index.lineOfOffset(0));
    try std.testing.expectEqual(@as(usize, 1), index.lineOfOffset(4));
    try std.testing.expectEqual(@as(usize, 2), index.lineOfOffset(8));
}
