const std = @import("std");
const Document = @import("document.zig").Document;

pub const NewlineMode = enum {
    lf,
    crlf,
};

pub const LoadResult = struct {
    doc: Document,
    newline_mode: NewlineMode,
    file_exists: bool,
};

pub const LoadError = error{
    BinaryFile,
    InvalidUtf8,
} || std.Io.Dir.ReadFileAllocError || std.mem.Allocator.Error;

pub fn loadDocument(
    allocator: std.mem.Allocator,
    io: std.Io,
    path: []const u8,
) LoadError!LoadResult {
    const bytes = try std.Io.Dir.cwd().readFileAlloc(io, path, allocator, .unlimited);
    errdefer allocator.free(bytes);

    if (std.mem.indexOfScalar(u8, bytes, 0) != null) return error.BinaryFile;
    if (!std.unicode.utf8ValidateSlice(bytes)) return error.InvalidUtf8;

    const mode: NewlineMode = if (std.mem.indexOf(u8, bytes, "\r\n") != null) .crlf else .lf;
    defer allocator.free(bytes);

    if (mode == .crlf) {
        const normalized = try normalizeCrlf(allocator, bytes);
        defer allocator.free(normalized);

        return .{
            .doc = try Document.initCopy(allocator, normalized),
            .newline_mode = mode,
            .file_exists = true,
        };
    }

    return .{
        .doc = try Document.initCopy(allocator, bytes),
        .newline_mode = mode,
        .file_exists = true,
    };
}

pub fn loadOrCreateDocument(
    allocator: std.mem.Allocator,
    io: std.Io,
    path: []const u8,
) LoadError!LoadResult {
    return loadDocument(allocator, io, path) catch |err| switch (err) {
        error.FileNotFound => .{
            .doc = try Document.initEmpty(allocator),
            .newline_mode = .lf,
            .file_exists = false,
        },
        else => return err,
    };
}

pub fn saveDocument(
    allocator: std.mem.Allocator,
    io: std.Io,
    doc: *const Document,
    path: []const u8,
    newline_mode: NewlineMode,
) !void {
    const text = try doc.textAlloc(allocator);
    defer allocator.free(text);

    const output = switch (newline_mode) {
        .lf => try allocator.dupe(u8, text),
        .crlf => try denormalizeCrlf(allocator, text),
    };
    defer allocator.free(output);

    var atomic = try std.Io.Dir.cwd().createFileAtomic(io, path, .{ .replace = true });
    defer atomic.deinit(io);

    var write_buffer: [4096]u8 = undefined;
    var writer = atomic.file.writer(io, &write_buffer);
    try writer.interface.writeAll(output);
    try writer.flush();
    try atomic.file.sync(io);
    try atomic.replace(io);
}

fn normalizeCrlf(allocator: std.mem.Allocator, bytes: []const u8) ![]u8 {
    var out: std.ArrayList(u8) = .empty;
    errdefer out.deinit(allocator);

    var i: usize = 0;
    while (i < bytes.len) : (i += 1) {
        if (bytes[i] == '\r' and i + 1 < bytes.len and bytes[i + 1] == '\n') continue;
        try out.append(allocator, bytes[i]);
    }
    return out.toOwnedSlice(allocator);
}

fn denormalizeCrlf(allocator: std.mem.Allocator, bytes: []const u8) ![]u8 {
    var out: std.ArrayList(u8) = .empty;
    errdefer out.deinit(allocator);

    for (bytes) |byte| {
        if (byte == '\n') {
            try out.appendSlice(allocator, "\r\n");
        } else {
            try out.append(allocator, byte);
        }
    }

    return out.toOwnedSlice(allocator);
}

test "newline normalization strips carriage returns" {
    const normalized = try normalizeCrlf(std.testing.allocator, "a\r\nb\r\n");
    defer std.testing.allocator.free(normalized);

    try std.testing.expectEqualStrings("a\nb\n", normalized);
}

test "load or create returns an empty document for missing paths" {
    const unique = "ulpad-missing-file-7b6074df8f0b";
    const result = try loadOrCreateDocument(std.testing.allocator, std.testing.io, unique);
    defer {
        var doc = result.doc;
        doc.deinit();
    }

    const actual = try result.doc.textAlloc(std.testing.allocator);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqual(false, result.file_exists);
    try std.testing.expectEqual(@as(usize, 1), result.doc.lineCount());
    try std.testing.expectEqualStrings("", actual);
}
