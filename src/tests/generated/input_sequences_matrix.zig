const std = @import("std");
const ulpad = @import("ulpad");
const input = ulpad.input;
const types = ulpad.types;
const clipboard = ulpad.clipboard;
const ansi = ulpad.ansi;
const tty = ulpad.tty;

test "input sequence 000" {
    const p = input.parseKey("\x1b[A").?;
    try std.testing.expectEqual(types.Key.arrow_up, p.key);
}

test "input sequence 001" {
    const p = input.parseKey("\x1b[B").?;
    try std.testing.expectEqual(types.Key.arrow_down, p.key);
}

test "input sequence 002" {
    const p = input.parseKey("\x1b[C").?;
    try std.testing.expectEqual(types.Key.arrow_right, p.key);
}

test "input sequence 003" {
    const p = input.parseKey("\x1b[D").?;
    try std.testing.expectEqual(types.Key.arrow_left, p.key);
}

test "input sequence 004" {
    const p = input.parseKey("\x1b[H").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}

test "input sequence 005" {
    const p = input.parseKey("\x1b[F").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}

test "input sequence 006" {
    const p = input.parseKey("\x1b[1~").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}

test "input sequence 007" {
    const p = input.parseKey("\x1b[3~").?;
    try std.testing.expectEqual(types.Key.delete, p.key);
}

test "input sequence 008" {
    const p = input.parseKey("\x1b[4~").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}

test "input sequence 009" {
    const p = input.parseKey("\x1b[5~").?;
    try std.testing.expectEqual(types.Key.page_up, p.key);
}

test "input sequence 010" {
    const p = input.parseKey("\x1b[6~").?;
    try std.testing.expectEqual(types.Key.page_down, p.key);
}

test "input sequence 011" {
    const p = input.parseKey("\x1b[7~").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}

test "input sequence 012" {
    const p = input.parseKey("\x1b[8~").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}

test "input sequence 013" {
    const p = input.parseKey("\x1bOH").?;
    try std.testing.expectEqual(types.Key.home, p.key);
}

test "input sequence 014" {
    const p = input.parseKey("\x1bOF").?;
    try std.testing.expectEqual(types.Key.end, p.key);
}

test "input unknown sequence 000" {
    const p = input.parseKey("\x1b").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}

test "input unknown sequence 001" {
    const p = input.parseKey("\x1b[Z").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}

test "input unknown sequence 002" {
    const p = input.parseKey("\x1bOZ").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}

test "input unknown sequence 003" {
    const p = input.parseKey("\x1b[9~").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}

test "input unknown sequence 004" {
    const p = input.parseKey("\x1b[1;5D").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}

test "input unknown sequence 005" {
    const p = input.parseKey("\x1b[1;5C").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}

test "input unknown sequence 006" {
    const p = input.parseKey("\x1b[1;5H").?;
    try std.testing.expectEqual(types.Key.escape, p.key);
}
