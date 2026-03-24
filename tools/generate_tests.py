from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "src" / "tests" / "generated"
OUT.mkdir(parents=True, exist_ok=True)


def esc(text: str) -> str:
    return (
        '"'
        + text.replace("\\", "\\\\")
        .replace("\x1b", "\\x1b")
        .replace("\n", "\\n")
        .replace("\r", "\\r")
        .replace("\t", "\\t")
        .replace('"', '\\"')
        + '"'
    )


files: dict[str, list[str]] = {}


def add(file_name: str, body: str) -> None:
    files.setdefault(file_name, []).append(body)


def header(imports: str) -> str:
    return imports + "\n\n"


def write_file(name: str, imports: str) -> None:
    body = header(imports) + "\n\n".join(files.get(name, [])) + "\n"
    (OUT / name).write_text(body)


# piece table ---------------------------------------------------------------
bases = [
    "",
    "a",
    "ab",
    "abc",
    "hello",
    "world",
    "aaaa",
    "abc\ndef",
    "x\ny",
    "012345",
]
inserts = ["X", "YZ", "\n", "!", "  "]

pt_imports = """
const std = @import(\"std\");
const PT = @import(\"ulpad\").PieceTable;
const h = @import(\"../helpers.zig\");
""".strip()

case_id = 0
for base in bases:
    for pos in range(len(base) + 1):
        ins = inserts[(pos + len(base)) % len(inserts)]
        expected = base[:pos] + ins + base[pos:]
        add(
            "piece_table_insert_matrix.zig",
            f"""test "piece_table insert matrix {case_id:04d}" {{
    var t = try PT.initCopy(h.A, {esc(base)});
    defer t.deinit();
    try t.insert({pos}, {esc(ins)});
    try h.expectTable(&t, {esc(expected)});
    try h.checkTable(&t);
}}""",
        )
        case_id += 1

case_id = 0
for base in [b for b in bases if len(b) <= 6]:
    for start in range(len(base) + 1):
        for end in range(start, len(base) + 1):
            expected = base[:start] + base[end:]
            add(
                "piece_table_delete_matrix.zig",
                f"""test "piece_table delete matrix {case_id:04d}" {{
    var t = try PT.initCopy(h.A, {esc(base)});
    defer t.deinit();
    try t.delete({start}, {end});
    try h.expectTable(&t, {esc(expected)});
    try h.checkTable(&t);
}}""",
            )
            case_id += 1

case_id = 0
for base in [b for b in bases if len(b) <= 6]:
    for start in range(len(base) + 1):
        for end in range(start, len(base) + 1):
            expected = base[start:end]
            add(
                "piece_table_copy_matrix.zig",
                f"""test "piece_table copy matrix {case_id:04d}" {{
    var t = try PT.initCopy(h.A, {esc(base)});
    defer t.deinit();
    const out = try t.copyRangeAlloc(h.A, {start}, {end});
    defer h.A.free(out);
    try std.testing.expectEqualStrings({esc(expected)}, out);
}}""",
            )
            case_id += 1


# document -----------------------------------------------------------------
doc_imports = """
const std = @import(\"std\");
const D = @import(\"ulpad\").Document;
const h = @import(\"../helpers.zig\");
""".strip()

case_id = 0
for base in bases:
    for pos in range(len(base) + 1):
        ins = inserts[(case_id + pos) % len(inserts)]
        expected = base[:pos] + ins + base[pos:]
        add(
            "document_insert_matrix.zig",
            f"""test "document insert matrix {case_id:04d}" {{
    var d = try D.initCopy(h.A, {esc(base)});
    defer d.deinit();
    try d.insert({pos}, {esc(ins)});
    try h.expectDoc(&d, {esc(expected)});
    try h.checkDoc(&d);
}}""",
        )
        case_id += 1

case_id = 0
for base in [b for b in bases if len(b) <= 6]:
    for start in range(len(base) + 1):
        for end in range(start, len(base) + 1):
            expected = base[:start] + base[end:]
            add(
                "document_delete_matrix.zig",
                f"""test "document delete matrix {case_id:04d}" {{
    var d = try D.initCopy(h.A, {esc(base)});
    defer d.deinit();
    try d.delete({start}, {end});
    try h.expectDoc(&d, {esc(expected)});
    try h.checkDoc(&d);
}}""",
            )
            case_id += 1

replacements = ["", "X", "ZZ", "\n", "END"]
case_id = 0
for base in [b for b in bases if len(b) <= 6]:
    for start in range(len(base) + 1):
        for end in range(start, len(base) + 1):
            repl = replacements[(case_id + start + end) % len(replacements)]
            expected = base[:start] + repl + base[end:]
            add(
                "document_replace_matrix.zig",
                f"""test "document replace matrix {case_id:04d}" {{
    var d = try D.initCopy(h.A, {esc(base)});
    defer d.deinit();
    try d.replaceRange({start}, {end}, {esc(repl)});
    try h.expectDoc(&d, {esc(expected)});
    try h.checkDoc(&d);
}}""",
            )
            case_id += 1


# line index ----------------------------------------------------------------
line_imports = """
const std = @import(\"std\");
const LineIndex = @import(\"ulpad\").LineIndex;
const h = @import(\"../helpers.zig\");
""".strip()

line_cases = [
    "",
    "a",
    "ab",
    "abc",
    "\n",
    "a\n",
    "\na",
    "a\nb",
    "a\n\n",
    "\n\n",
    "abc\ndef",
    "abc\ndef\n",
    "x\ny\nz",
    "longer\ntext\nhere",
]

case_id = 0
for text in line_cases:
    expected_starts = [0]
    for i, ch in enumerate(text):
        if ch == "\n":
            expected_starts.append(i + 1)
    add(
        "line_index_counts.zig",
        f"""test "line index lineCount {case_id:04d}" {{
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild({esc(text)});
    try std.testing.expectEqual(@as(usize, {len(expected_starts)}), idx.lineCount());
    try h.checkLineIndex({esc(text)}, &idx);
}}""",
    )
    for line_no, start in enumerate(expected_starts):
        add(
            "line_index_starts.zig",
            f"""test "line index start {case_id:04d}-{line_no:02d}" {{
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild({esc(text)});
    try std.testing.expectEqual(@as(usize, {start}), idx.lineStart({line_no}));
}}""",
        )
    for offset in range(len(text) + 1):
        line = 0
        for i, ch in enumerate(text):
            if i >= offset:
                break
            if ch == "\n":
                line += 1
        add(
            "line_index_offsets.zig",
            f"""test "line index offset {case_id:04d}-{offset:02d}" {{
    var idx = LineIndex.init(h.A);
    defer idx.deinit();
    try idx.rebuild({esc(text)});
    try std.testing.expectEqual(@as(usize, {line}), idx.lineOfOffset({offset}));
}}""",
        )
    case_id += 1


# search --------------------------------------------------------------------
search_imports = """
const std = @import(\"std\");
const ulpad = @import(\"ulpad\");
const D = ulpad.Document;
const S = ulpad.search;
const h = @import(\"../helpers.zig\");
""".strip()

find_cases = [
    ("", "a", 0, "forward"),
    ("a", "a", 0, "forward"),
    ("a", "a", 0, "backward"),
    ("abc", "bc", 0, "forward"),
    ("abc", "bc", 2, "backward"),
    ("aaaa", "aa", 0, "forward"),
    ("aaaa", "aa", 1, "forward"),
    ("abc def abc", "abc", 0, "forward"),
    ("abc def abc", "abc", 11, "backward"),
    ("hello\nworld", "world", 0, "forward"),
    ("cat dog cat bird cat", "cat", 0, "forward"),
    ("cat dog cat bird cat", "cat", 3, "forward"),
]
case_id = 0
for text, needle, from_, direction in find_cases:
    if needle == "":
        expected = None
    else:
        if direction == "forward":
            idx = text.find(needle, min(from_, len(text)))
        else:
            upto = min(len(text), min(from_, len(text)) + len(needle))
            idx = text.rfind(needle, 0, upto)
        expected = None if idx == -1 else (idx, idx + len(needle))
    body = [
        f"var d = try D.initCopy(h.A, {esc(text)});",
        "defer d.deinit();",
    ]
    if expected is None:
        body.append(f"try h.expectNoFind(&d, {esc(needle)}, {from_}, .{direction});")
    else:
        body.append(
            f"try h.expectFind(&d, {esc(needle)}, {from_}, .{direction}, {expected[0]}, {expected[1]});"
        )
    add(
        "search_find_matrix.zig",
        f"""test "search find matrix {case_id:04d}" {{
    {" ".join(body)}
}}""",
    )
    case_id += 1

replace_cases = [
    ("", "a", "x"),
    ("aaa", "a", "a"),
    ("aaa", "a", "abc"),
    ("aaaaaa", "aa", "b"),
    ("a b c", " ", "___"),
    ("aXbXc", "X", ""),
    ("foo bar foo", "foo", "FOO"),
    ("v1.0.0", "v1", "v2"),
    ("abcabcabc", "abc", "a"),
    ("hello world", "xyz", "abc"),
]
case_id = 0
for text, needle, repl in replace_cases:
    expected = text if needle == "" else text.replace(needle, repl)
    count = 0 if needle == "" else text.count(needle)
    add(
        "search_replace_matrix.zig",
        f"""test "search replace matrix {case_id:04d}" {{
    var d = try D.initCopy(h.A, {esc(text)});
    defer d.deinit();
    const count = try S.replaceAll(&d, {esc(needle)}, {esc(repl)});
    try std.testing.expectEqual(@as(usize, {count}), count);
    try h.expectDoc(&d, {esc(expected)});
    try h.checkDoc(&d);
}}""",
    )
    case_id += 1


# render --------------------------------------------------------------------
render_imports = """
const std = @import(\"std\");
const ulpad = @import(\"ulpad\");
const D = ulpad.Document;
const R = ulpad.render;
const h = @import(\"../helpers.zig\");
""".strip()

render_docs = ["", "hello", "aaa\nbbb", "aaa\nbbb\nccc", "0123456789ABCDEFGHIJ"]
case_id = 0
for text in render_docs:
    for rows, cols, top, left in [
        (5, 20, 0, 0),
        (6, 10, 0, 0),
        (8, 40, 1, 0),
        (6, 8, 0, 3),
    ]:
        add(
            "render_matrix.zig",
            f"""test "render matrix {case_id:04d}" {{
    var d = try D.initCopy(h.A, {esc(text)});
    defer d.deinit();
    const frame = try R.renderFrame(h.A, &d, 0, null, .{{ .top_line = {top}, .left_col = {left} }}, .{{ .rows = {rows}, .cols = {cols} }}, "status", "prompt");
    defer h.A.free(frame);
    try std.testing.expect(frame.len > 0);
}}""",
        )
        case_id += 1


# input/system --------------------------------------------------------------
system_imports = """
const std = @import(\"std\");
const ulpad = @import(\"ulpad\");
const input = ulpad.input;
const types = ulpad.types;
const clipboard = ulpad.clipboard;
const ansi = ulpad.ansi;
const tty = ulpad.tty;
""".strip()

for byte in range(256):
    if byte == 27:
        check = "try std.testing.expectEqual(types.Key.escape, p.key);"
    elif byte == 9:
        check = "try std.testing.expectEqual(types.Key.tab, p.key);"
    elif byte in (10, 13):
        check = "try std.testing.expectEqual(types.Key.enter, p.key);"
    elif byte == 127:
        check = "try std.testing.expectEqual(types.Key.backspace, p.key);"
    elif 1 <= byte <= 26:
        ctrl = chr(ord("a") + byte - 1)
        check = f"try std.testing.expectEqual(types.Key{{ .ctrl = '{ctrl}' }}, p.key);"
    else:
        check = f"try std.testing.expectEqual(types.Key{{ .char = {byte} }}, p.key);"
    add(
        "input_bytes_matrix.zig",
        f"""test "input byte {byte:03d}" {{
    const p = input.parseKey(&.{{{byte}}}).?;
    {check}
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}}""",
    )

esc_sequences = [
    ("\\x1b[A", "types.Key.arrow_up"),
    ("\\x1b[B", "types.Key.arrow_down"),
    ("\\x1b[C", "types.Key.arrow_right"),
    ("\\x1b[D", "types.Key.arrow_left"),
    ("\\x1b[H", "types.Key.home"),
    ("\\x1b[F", "types.Key.end"),
    ("\\x1b[1~", "types.Key.home"),
    ("\\x1b[3~", "types.Key.delete"),
    ("\\x1b[4~", "types.Key.end"),
    ("\\x1b[5~", "types.Key.page_up"),
    ("\\x1b[6~", "types.Key.page_down"),
    ("\\x1b[7~", "types.Key.home"),
    ("\\x1b[8~", "types.Key.end"),
    ("\\x1bOH", "types.Key.home"),
    ("\\x1bOF", "types.Key.end"),
]
for i, (seq, keyexpr) in enumerate(esc_sequences):
    add(
        "input_sequences_matrix.zig",
        f'''test "input sequence {i:03d}" {{
    const p = input.parseKey("{seq}").?;
    try std.testing.expectEqual({keyexpr}, p.key);
}}''',
    )

for i, seq in enumerate(
    ["\x1b", "\x1b[Z", "\x1bOZ", "\x1b[9~", "\x1b[1;5D", "\x1b[1;5C", "\x1b[1;5H"]
):
    literal = esc(seq)
    add(
        "input_sequences_matrix.zig",
        f"""test "input unknown sequence {i:03d}" {{
    const p = input.parseKey({literal}).?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}}""",
    )

clip_texts = ["", "a", "hello", "türkçe", "line1\nline2", "X" * 32]
for i, text in enumerate(clip_texts):
    add(
        "system_misc_matrix.zig",
        f"""test "clipboard set get {i:03d}" {{
    var cb = clipboard.Clipboard.init(std.testing.allocator);
    defer cb.deinit();
    try cb.set({esc(text)});
    try std.testing.expectEqualStrings({esc(text)}, cb.get());
}}""",
    )
    add(
        "system_misc_matrix.zig",
        f"""test "clipboard osc52 {i:03d}" {{
    const seq = try clipboard.osc52SequenceAllocFromText(std.testing.allocator, {esc(text)});
    defer std.testing.allocator.free(seq);
    try std.testing.expect(std.mem.startsWith(u8, seq, "\\x1b]52;c;"));
    try std.testing.expect(std.mem.endsWith(u8, seq, "\\x07"));
}}""",
    )

add(
    "system_misc_matrix.zig",
    """test "ansi constants exact" {
    try std.testing.expectEqualStrings("\\x1b[?1049h", ansi.enter_alt_screen);
    try std.testing.expectEqualStrings("\\x1b[?1049l", ansi.leave_alt_screen);
    try std.testing.expectEqualStrings("\\x1b[2J", ansi.clear_screen);
    try std.testing.expectEqualStrings("\\x1b[H", ansi.cursor_home);
}""",
)
add(
    "system_misc_matrix.zig",
    """test "types viewport defaults" {
    const vp: types.Viewport = .{};
    try std.testing.expectEqual(@as(usize, 0), vp.top_line);
    try std.testing.expectEqual(@as(usize, 0), vp.left_col);
}""",
)
add(
    "system_misc_matrix.zig",
    """test "tty ensureInteractive non-tty error" {
    try std.testing.expectError(error.NotATerminal, tty.ensureInteractive(std.testing.io));
}""",
)
add(
    "system_misc_matrix.zig",
    """test "tty screenSize non-tty error" {
    try std.testing.expectError(error.NotATerminal, tty.screenSize());
}""",
)
add(
    "system_misc_matrix.zig",
    """test "rawmode leave inactive no-op" {
    var mode: tty.RawMode = .{ .original = undefined, .active = false };
    mode.leave();
    try std.testing.expectEqual(false, mode.active);
}""",
)


generated_files = sorted(files)
for file_name in generated_files:
    if file_name.startswith("piece_table"):
        write_file(file_name, pt_imports)
    elif file_name.startswith("document"):
        write_file(file_name, doc_imports)
    elif file_name.startswith("line_index"):
        write_file(file_name, line_imports)
    elif file_name.startswith("search"):
        write_file(file_name, search_imports)
    elif file_name.startswith("render"):
        write_file(file_name, render_imports)
    else:
        write_file(file_name, system_imports)

all_body = (
    "test {\n"
    + "\n".join(f'    _ = @import("{name}");' for name in generated_files)
    + "\n}\n"
)
(OUT / "all.zig").write_text(all_body)

count = sum(test.count('test "') for tests in files.values() for test in tests)
print(count)
