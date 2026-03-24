const std = @import("std");
const ulpad = @import("ulpad");
const editor_io = ulpad.editor_io;
const Document = ulpad.Document;
const h = @import("helpers.zig");

fn tmpRelPath(name: []const u8) !struct { tmp: std.testing.TmpDir, path: []u8 } {
    const tmp = std.testing.tmpDir(.{});
    const path = try std.fmt.allocPrint(h.A, ".zig-cache/tmp/{s}/{s}", .{ tmp.sub_path, name });
    return .{ .tmp = tmp, .path = path };
}

test "editor_io: loadDocument reads LF text" {
    var tmp = try tmpRelPath("lf.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    try tmp.tmp.dir.writeFile(std.testing.io, .{ .sub_path = "lf.txt", .data = "a\nb\n" });

    const result = try editor_io.loadDocument(h.A, std.testing.io, tmp.path);
    defer {
        var doc = result.doc;
        doc.deinit();
    }
    try std.testing.expectEqual(editor_io.NewlineMode.lf, result.newline_mode);
    try std.testing.expectEqual(true, result.file_exists);
    try h.expectDoc(&result.doc, "a\nb\n");
}

test "editor_io: loadDocument normalizes CRLF" {
    var tmp = try tmpRelPath("crlf.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    try tmp.tmp.dir.writeFile(std.testing.io, .{ .sub_path = "crlf.txt", .data = "a\r\nb\r\n" });

    const result = try editor_io.loadDocument(h.A, std.testing.io, tmp.path);
    defer {
        var doc = result.doc;
        doc.deinit();
    }
    try std.testing.expectEqual(editor_io.NewlineMode.crlf, result.newline_mode);
    try h.expectDoc(&result.doc, "a\nb\n");
}

test "editor_io: loadDocument rejects binary data" {
    var tmp = try tmpRelPath("binary.bin");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    try tmp.tmp.dir.writeFile(std.testing.io, .{ .sub_path = "binary.bin", .data = "ab\x00cd" });
    try std.testing.expectError(error.BinaryFile, editor_io.loadDocument(h.A, std.testing.io, tmp.path));
}

test "editor_io: loadDocument rejects invalid utf8" {
    var tmp = try tmpRelPath("utf8.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    try tmp.tmp.dir.writeFile(std.testing.io, .{ .sub_path = "utf8.txt", .data = "a\x80b" });
    try std.testing.expectError(error.InvalidUtf8, editor_io.loadDocument(h.A, std.testing.io, tmp.path));
}

test "editor_io: loadOrCreateDocument returns empty doc for missing file" {
    var tmp = try tmpRelPath("missing.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    const result = try editor_io.loadOrCreateDocument(h.A, std.testing.io, tmp.path);
    defer {
        var doc = result.doc;
        doc.deinit();
    }
    try std.testing.expectEqual(false, result.file_exists);
    try std.testing.expectEqual(editor_io.NewlineMode.lf, result.newline_mode);
    try h.expectDoc(&result.doc, "");
}

test "editor_io: saveDocument writes LF output" {
    var tmp = try tmpRelPath("save-lf.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    var doc = try Document.initCopy(h.A, "a\nb\n");
    defer doc.deinit();

    try editor_io.saveDocument(h.A, std.testing.io, &doc, tmp.path, .lf);
    const bytes = try tmp.tmp.dir.readFileAlloc(std.testing.io, "save-lf.txt", h.A, .unlimited);
    defer h.A.free(bytes);
    try std.testing.expectEqualStrings("a\nb\n", bytes);
}

test "editor_io: saveDocument writes CRLF output" {
    var tmp = try tmpRelPath("save-crlf.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    var doc = try Document.initCopy(h.A, "a\nb\n");
    defer doc.deinit();

    try editor_io.saveDocument(h.A, std.testing.io, &doc, tmp.path, .crlf);
    const bytes = try tmp.tmp.dir.readFileAlloc(std.testing.io, "save-crlf.txt", h.A, .unlimited);
    defer h.A.free(bytes);
    try std.testing.expectEqualStrings("a\r\nb\r\n", bytes);
}

test "editor_io: save then load roundtrip LF" {
    var tmp = try tmpRelPath("roundtrip-lf.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    var doc = try Document.initCopy(h.A, "hello\nworld");
    defer doc.deinit();
    try editor_io.saveDocument(h.A, std.testing.io, &doc, tmp.path, .lf);

    const loaded = try editor_io.loadDocument(h.A, std.testing.io, tmp.path);
    defer {
        var d = loaded.doc;
        d.deinit();
    }
    try h.expectDoc(&loaded.doc, "hello\nworld");
    try std.testing.expectEqual(editor_io.NewlineMode.lf, loaded.newline_mode);
}

test "editor_io: save then load roundtrip CRLF" {
    var tmp = try tmpRelPath("roundtrip-crlf.txt");
    defer tmp.tmp.cleanup();
    defer h.A.free(tmp.path);

    var doc = try Document.initCopy(h.A, "hello\nworld\n");
    defer doc.deinit();
    try editor_io.saveDocument(h.A, std.testing.io, &doc, tmp.path, .crlf);

    const loaded = try editor_io.loadDocument(h.A, std.testing.io, tmp.path);
    defer {
        var d = loaded.doc;
        d.deinit();
    }
    try h.expectDoc(&loaded.doc, "hello\nworld\n");
    try std.testing.expectEqual(editor_io.NewlineMode.crlf, loaded.newline_mode);
}
