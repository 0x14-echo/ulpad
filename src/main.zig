const std = @import("std");

pub fn main(_: std.process.Init) !void {
    try std.io.getStdOut().writer().print("ulpad bootstrap\n", .{});
}
