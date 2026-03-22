const std = @import("std");

pub const Clipboard = struct {
    allocator: std.mem.Allocator,
    bytes: std.ArrayList(u8),

    pub fn init(allocator: std.mem.Allocator) Clipboard {
        return .{
            .allocator = allocator,
            .bytes = .empty,
        };
    }

    pub fn deinit(self: *Clipboard) void {
        self.bytes.deinit(self.allocator);
    }

    pub fn set(self: *Clipboard, text: []const u8) !void {
        self.bytes.clearRetainingCapacity();
        try self.bytes.appendSlice(self.allocator, text);
    }

    pub fn get(self: *const Clipboard) []const u8 {
        return self.bytes.items;
    }
};

test "set replaces previous clipboard contents" {
    var clipboard = Clipboard.init(std.testing.allocator);
    defer clipboard.deinit();

    try clipboard.set("alpha");
    try clipboard.set("beta");

    try std.testing.expectEqualStrings("beta", clipboard.get());
}
