pub const piece_table = @import("piece_table.zig");
pub const PieceTable = piece_table.PieceTable;
pub const line_index = @import("line_index.zig");
pub const LineIndex = line_index.LineIndex;
pub const document = @import("document.zig");
pub const Document = document.Document;
pub const search = @import("search.zig");
pub const Search = search;
pub const clipboard = @import("clipboard.zig");
pub const Clipboard = clipboard.Clipboard;

test {
    _ = piece_table;
    _ = line_index;
    _ = document;
    _ = search;
    _ = clipboard;
}
