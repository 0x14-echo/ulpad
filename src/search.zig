const std = @import("std");
const Document = @import("document.zig").Document;

pub const Direction = enum {
    forward,
    backward,
};

pub const Match = struct {
    start: usize,
    end: usize,
};

pub fn find(doc: *const Document, needle: []const u8, from: usize, direction: Direction) !?Match {
    if (needle.len == 0) return null;

    const text = try doc.textAlloc(doc.allocator);
    defer doc.allocator.free(text);

    const clamped_from = @min(from, text.len);
    return switch (direction) {
        .forward => if (std.mem.indexOf(u8, text[clamped_from..], needle)) |relative| {
            const start = clamped_from + relative;
            return .{ .start = start, .end = start + needle.len };
        } else null,
        .backward => if (std.mem.lastIndexOf(
            u8,
            text[0..@min(text.len, clamped_from + needle.len)],
            needle,
        )) |start| {
            return .{ .start = start, .end = start + needle.len };
        } else null,
    };
}

pub fn findAll(doc: *const Document, needle: []const u8) !usize {
    if (needle.len == 0) return 0;

    const text = try doc.textAlloc(doc.allocator);
    defer doc.allocator.free(text);

    var count: usize = 0;
    var pos: usize = 0;
    while (std.mem.indexOf(u8, text[pos..], needle)) |relative| {
        count += 1;
        pos += relative + needle.len;
    }
    return count;
}

pub fn replaceAll(doc: *Document, needle: []const u8, replacement: []const u8) !usize {
    if (needle.len == 0) return 0;

    var count: usize = 0;
    var cursor: usize = 0;
    while (try find(doc, needle, cursor, .forward)) |match| {
        try doc.replaceRange(match.start, match.end, replacement);
        cursor = match.start + replacement.len;
        count += 1;
    }
    return count;
}

test "find supports forward and backward search" {
    var doc = try Document.initEmpty(std.testing.allocator);
    defer doc.deinit();

    try doc.insert(0, "one two one");

    const forward = (try find(&doc, "one", 0, .forward)).?;
    const backward = (try find(&doc, "one", doc.lineCount() + 8, .backward)).?;

    try std.testing.expectEqual(@as(usize, 0), forward.start);
    try std.testing.expectEqual(@as(usize, 3), forward.end);
    try std.testing.expectEqual(@as(usize, 8), backward.start);
    try std.testing.expectEqual(@as(usize, 11), backward.end);
}

test "replace all rewrites every match" {
    var doc = try Document.initEmpty(std.testing.allocator);
    defer doc.deinit();

    try doc.insert(0, "cat dog cat");

    const count = try replaceAll(&doc, "cat", "lynx");
    const actual = try doc.textAlloc(std.testing.allocator);
    defer std.testing.allocator.free(actual);

    try std.testing.expectEqual(@as(usize, 2), count);
    try std.testing.expectEqualStrings("lynx dog lynx", actual);
}
