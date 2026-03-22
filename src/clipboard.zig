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

    pub fn osc52SequenceAlloc(self: *const Clipboard, allocator: std.mem.Allocator) ![]u8 {
        return osc52SequenceAllocFromText(allocator, self.bytes.items);
    }
};

pub fn osc52SequenceAllocFromText(allocator: std.mem.Allocator, text: []const u8) ![]u8 {
    const encoded_len = std.base64.standard.Encoder.calcSize(text.len);
    const prefix = "\x1b]52;c;";
    const suffix = "\x07";

    var out = try allocator.alloc(u8, prefix.len + encoded_len + suffix.len);
    @memcpy(out[0..prefix.len], prefix);
    _ = std.base64.standard.Encoder.encode(out[prefix.len .. prefix.len + encoded_len], text);
    @memcpy(out[prefix.len + encoded_len ..], suffix);
    return out;
}

pub fn tryReadSystem(allocator: std.mem.Allocator, io: std.Io) !?[]u8 {
    const commands = [_][]const []const u8{
        &.{ "wl-paste", "--no-newline" },
        &.{ "xclip", "-selection", "clipboard", "-o" },
        &.{ "xsel", "--clipboard", "--output" },
    };

    for (commands) |argv| {
        const result = std.process.run(allocator, io, .{
            .argv = argv,
            .stderr_limit = .nothing,
            .stdout_limit = .unlimited,
        }) catch |err| switch (err) {
            error.FileNotFound => continue,
            else => continue,
        };
        defer allocator.free(result.stderr);

        switch (result.term) {
            .exited => |code| {
                if (code == 0) return result.stdout;
                allocator.free(result.stdout);
            },
            else => allocator.free(result.stdout),
        }
    }

    return null;
}

test "set replaces previous clipboard contents" {
    var clipboard = Clipboard.init(std.testing.allocator);
    defer clipboard.deinit();

    try clipboard.set("alpha");
    try clipboard.set("beta");

    try std.testing.expectEqualStrings("beta", clipboard.get());
}

test "osc52 sequence wraps clipboard text" {
    const sequence = try osc52SequenceAllocFromText(std.testing.allocator, "hi");
    defer std.testing.allocator.free(sequence);

    try std.testing.expect(std.mem.startsWith(u8, sequence, "\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, sequence, "\x07"));
}
