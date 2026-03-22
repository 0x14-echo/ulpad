const std = @import("std");
const linux = std.os.linux;
const posix = std.posix;
const ScreenSize = @import("types.zig").ScreenSize;

pub const RawMode = struct {
    original: posix.termios,
    active: bool = false,

    pub fn leave(self: *RawMode) void {
        if (!self.active) return;
        posix.tcsetattr(posix.STDIN_FILENO, .FLUSH, self.original) catch {};
        self.active = false;
    }
};

pub fn ensureInteractive(io: std.Io) !void {
    if (!try std.Io.File.stdin().isTty(io)) return error.NotATerminal;
    if (!try std.Io.File.stdout().isTty(io)) return error.NotATerminal;
}

pub fn enterRawMode() !RawMode {
    const original = try posix.tcgetattr(posix.STDIN_FILENO);
    var raw = original;
    raw.iflag.BRKINT = false;
    raw.iflag.ICRNL = false;
    raw.iflag.INPCK = false;
    raw.iflag.ISTRIP = false;
    raw.iflag.IXON = false;
    raw.oflag.OPOST = false;
    raw.lflag.ECHO = false;
    raw.lflag.ICANON = false;
    raw.lflag.IEXTEN = false;
    raw.lflag.ISIG = false;
    raw.cc[@intFromEnum(linux.V.MIN)] = 0;
    raw.cc[@intFromEnum(linux.V.TIME)] = 1;
    try posix.tcsetattr(posix.STDIN_FILENO, .FLUSH, raw);
    return .{ .original = original, .active = true };
}

pub fn screenSize() !ScreenSize {
    var ws: posix.winsize = undefined;
    switch (posix.errno(linux.ioctl(posix.STDOUT_FILENO, linux.T.IOCGWINSZ, @intFromPtr(&ws)))) {
        .SUCCESS => {},
        else => return error.NotATerminal,
    }
    return .{
        .rows = @max(@as(usize, ws.row), 3),
        .cols = @max(@as(usize, ws.col), 20),
    };
}
