const std = @import("std");
const Key = @import("types.zig").Key;

pub fn parseKey(bytes: []const u8) ?struct { key: Key, consumed: usize } {
    if (bytes.len == 0) return null;
    const byte = bytes[0];

    if (byte == '\x1b') {
        if (bytes.len >= 3 and bytes[1] == '[') {
            return switch (bytes[2]) {
                'A' => .{ .key = .arrow_up, .consumed = 3 },
                'B' => .{ .key = .arrow_down, .consumed = 3 },
                'C' => .{ .key = .arrow_right, .consumed = 3 },
                'D' => .{ .key = .arrow_left, .consumed = 3 },
                'H' => .{ .key = .home, .consumed = 3 },
                'F' => .{ .key = .end, .consumed = 3 },
                '1', '3', '4', '5', '6', '7', '8' => if (bytes.len >= 4 and bytes[3] == '~') switch (bytes[2]) {
                    '1', '7' => .{ .key = .home, .consumed = 4 },
                    '3' => .{ .key = .delete, .consumed = 4 },
                    '4', '8' => .{ .key = .end, .consumed = 4 },
                    '5' => .{ .key = .page_up, .consumed = 4 },
                    '6' => .{ .key = .page_down, .consumed = 4 },
                    else => .{ .key = .escape, .consumed = 1 },
                } else .{ .key = .escape, .consumed = 1 },
                else => .{ .key = .escape, .consumed = 1 },
            };
        }

        if (bytes.len >= 3 and bytes[1] == 'O') {
            return switch (bytes[2]) {
                'H' => .{ .key = .home, .consumed = 3 },
                'F' => .{ .key = .end, .consumed = 3 },
                else => .{ .key = .escape, .consumed = 1 },
            };
        }

        return .{ .key = .escape, .consumed = 1 };
    }

    if (byte == 9) return .{ .key = .tab, .consumed = 1 };
    if (byte == 10 or byte == 13) return .{ .key = .enter, .consumed = 1 };
    if (byte == 127) return .{ .key = .backspace, .consumed = 1 };
    if (byte >= 1 and byte <= 26) return .{ .key = .{ .ctrl = 'a' + byte - 1 }, .consumed = 1 };
    return .{ .key = .{ .char = byte }, .consumed = 1 };
}

test "parse key handles control and arrow sequences" {
    const ctrl_s = parseKey(&.{19}).?;
    try std.testing.expectEqual(Key{ .ctrl = 's' }, ctrl_s.key);

    const arrow = parseKey("\x1b[C").?;
    try std.testing.expectEqual(Key.arrow_right, arrow.key);

    const delete = parseKey("\x1b[3~").?;
    try std.testing.expectEqual(Key.delete, delete.key);
}

pub fn readKey(fd: std.posix.fd_t) !?Key {
    var buffer: [8]u8 = undefined;
    const first_read = try std.posix.read(fd, buffer[0..1]);
    if (first_read == 0) return null;

    if (buffer[0] == '\x1b') {
        const extra = try std.posix.read(fd, buffer[1..]);
        if (parseKey(buffer[0 .. 1 + extra])) |parsed| {
            return parsed.key;
        }
        return .escape;
    }

    return parseKey(buffer[0..1]).?.key;
}
