const std = @import("std");
const ulpad = @import("ulpad");
const input = ulpad.input;
const types = ulpad.types;
const clipboard = ulpad.clipboard;
const ansi = ulpad.ansi;
const tty = ulpad.tty;

test "input byte 000" {
    const p = input.parseKey(&.{0}).?;
    try std.testing.expectEqual(types.Key{ .char = 0 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 001" {
    const p = input.parseKey(&.{1}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'a' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 002" {
    const p = input.parseKey(&.{2}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'b' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 003" {
    const p = input.parseKey(&.{3}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'c' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 004" {
    const p = input.parseKey(&.{4}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'd' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 005" {
    const p = input.parseKey(&.{5}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'e' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 006" {
    const p = input.parseKey(&.{6}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'f' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 007" {
    const p = input.parseKey(&.{7}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'g' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 008" {
    const p = input.parseKey(&.{8}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'h' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 009" {
    const p = input.parseKey(&.{9}).?;
    try std.testing.expectEqual(types.Key.tab, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 010" {
    const p = input.parseKey(&.{10}).?;
    try std.testing.expectEqual(types.Key.enter, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 011" {
    const p = input.parseKey(&.{11}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'k' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 012" {
    const p = input.parseKey(&.{12}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'l' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 013" {
    const p = input.parseKey(&.{13}).?;
    try std.testing.expectEqual(types.Key.enter, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 014" {
    const p = input.parseKey(&.{14}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'n' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 015" {
    const p = input.parseKey(&.{15}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'o' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 016" {
    const p = input.parseKey(&.{16}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'p' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 017" {
    const p = input.parseKey(&.{17}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'q' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 018" {
    const p = input.parseKey(&.{18}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'r' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 019" {
    const p = input.parseKey(&.{19}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 's' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 020" {
    const p = input.parseKey(&.{20}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 't' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 021" {
    const p = input.parseKey(&.{21}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'u' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 022" {
    const p = input.parseKey(&.{22}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'v' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 023" {
    const p = input.parseKey(&.{23}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'w' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 024" {
    const p = input.parseKey(&.{24}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'x' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 025" {
    const p = input.parseKey(&.{25}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'y' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 026" {
    const p = input.parseKey(&.{26}).?;
    try std.testing.expectEqual(types.Key{ .ctrl = 'z' }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 027" {
    const p = input.parseKey(&.{27}).?;
    try std.testing.expectEqual(types.Key.escape, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 028" {
    const p = input.parseKey(&.{28}).?;
    try std.testing.expectEqual(types.Key{ .char = 28 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 029" {
    const p = input.parseKey(&.{29}).?;
    try std.testing.expectEqual(types.Key{ .char = 29 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 030" {
    const p = input.parseKey(&.{30}).?;
    try std.testing.expectEqual(types.Key{ .char = 30 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 031" {
    const p = input.parseKey(&.{31}).?;
    try std.testing.expectEqual(types.Key{ .char = 31 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 032" {
    const p = input.parseKey(&.{32}).?;
    try std.testing.expectEqual(types.Key{ .char = 32 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 033" {
    const p = input.parseKey(&.{33}).?;
    try std.testing.expectEqual(types.Key{ .char = 33 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 034" {
    const p = input.parseKey(&.{34}).?;
    try std.testing.expectEqual(types.Key{ .char = 34 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 035" {
    const p = input.parseKey(&.{35}).?;
    try std.testing.expectEqual(types.Key{ .char = 35 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 036" {
    const p = input.parseKey(&.{36}).?;
    try std.testing.expectEqual(types.Key{ .char = 36 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 037" {
    const p = input.parseKey(&.{37}).?;
    try std.testing.expectEqual(types.Key{ .char = 37 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 038" {
    const p = input.parseKey(&.{38}).?;
    try std.testing.expectEqual(types.Key{ .char = 38 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 039" {
    const p = input.parseKey(&.{39}).?;
    try std.testing.expectEqual(types.Key{ .char = 39 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 040" {
    const p = input.parseKey(&.{40}).?;
    try std.testing.expectEqual(types.Key{ .char = 40 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 041" {
    const p = input.parseKey(&.{41}).?;
    try std.testing.expectEqual(types.Key{ .char = 41 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 042" {
    const p = input.parseKey(&.{42}).?;
    try std.testing.expectEqual(types.Key{ .char = 42 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 043" {
    const p = input.parseKey(&.{43}).?;
    try std.testing.expectEqual(types.Key{ .char = 43 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 044" {
    const p = input.parseKey(&.{44}).?;
    try std.testing.expectEqual(types.Key{ .char = 44 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 045" {
    const p = input.parseKey(&.{45}).?;
    try std.testing.expectEqual(types.Key{ .char = 45 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 046" {
    const p = input.parseKey(&.{46}).?;
    try std.testing.expectEqual(types.Key{ .char = 46 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 047" {
    const p = input.parseKey(&.{47}).?;
    try std.testing.expectEqual(types.Key{ .char = 47 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 048" {
    const p = input.parseKey(&.{48}).?;
    try std.testing.expectEqual(types.Key{ .char = 48 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 049" {
    const p = input.parseKey(&.{49}).?;
    try std.testing.expectEqual(types.Key{ .char = 49 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 050" {
    const p = input.parseKey(&.{50}).?;
    try std.testing.expectEqual(types.Key{ .char = 50 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 051" {
    const p = input.parseKey(&.{51}).?;
    try std.testing.expectEqual(types.Key{ .char = 51 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 052" {
    const p = input.parseKey(&.{52}).?;
    try std.testing.expectEqual(types.Key{ .char = 52 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 053" {
    const p = input.parseKey(&.{53}).?;
    try std.testing.expectEqual(types.Key{ .char = 53 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 054" {
    const p = input.parseKey(&.{54}).?;
    try std.testing.expectEqual(types.Key{ .char = 54 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 055" {
    const p = input.parseKey(&.{55}).?;
    try std.testing.expectEqual(types.Key{ .char = 55 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 056" {
    const p = input.parseKey(&.{56}).?;
    try std.testing.expectEqual(types.Key{ .char = 56 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 057" {
    const p = input.parseKey(&.{57}).?;
    try std.testing.expectEqual(types.Key{ .char = 57 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 058" {
    const p = input.parseKey(&.{58}).?;
    try std.testing.expectEqual(types.Key{ .char = 58 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 059" {
    const p = input.parseKey(&.{59}).?;
    try std.testing.expectEqual(types.Key{ .char = 59 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 060" {
    const p = input.parseKey(&.{60}).?;
    try std.testing.expectEqual(types.Key{ .char = 60 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 061" {
    const p = input.parseKey(&.{61}).?;
    try std.testing.expectEqual(types.Key{ .char = 61 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 062" {
    const p = input.parseKey(&.{62}).?;
    try std.testing.expectEqual(types.Key{ .char = 62 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 063" {
    const p = input.parseKey(&.{63}).?;
    try std.testing.expectEqual(types.Key{ .char = 63 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 064" {
    const p = input.parseKey(&.{64}).?;
    try std.testing.expectEqual(types.Key{ .char = 64 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 065" {
    const p = input.parseKey(&.{65}).?;
    try std.testing.expectEqual(types.Key{ .char = 65 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 066" {
    const p = input.parseKey(&.{66}).?;
    try std.testing.expectEqual(types.Key{ .char = 66 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 067" {
    const p = input.parseKey(&.{67}).?;
    try std.testing.expectEqual(types.Key{ .char = 67 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 068" {
    const p = input.parseKey(&.{68}).?;
    try std.testing.expectEqual(types.Key{ .char = 68 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 069" {
    const p = input.parseKey(&.{69}).?;
    try std.testing.expectEqual(types.Key{ .char = 69 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 070" {
    const p = input.parseKey(&.{70}).?;
    try std.testing.expectEqual(types.Key{ .char = 70 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 071" {
    const p = input.parseKey(&.{71}).?;
    try std.testing.expectEqual(types.Key{ .char = 71 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 072" {
    const p = input.parseKey(&.{72}).?;
    try std.testing.expectEqual(types.Key{ .char = 72 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 073" {
    const p = input.parseKey(&.{73}).?;
    try std.testing.expectEqual(types.Key{ .char = 73 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 074" {
    const p = input.parseKey(&.{74}).?;
    try std.testing.expectEqual(types.Key{ .char = 74 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 075" {
    const p = input.parseKey(&.{75}).?;
    try std.testing.expectEqual(types.Key{ .char = 75 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 076" {
    const p = input.parseKey(&.{76}).?;
    try std.testing.expectEqual(types.Key{ .char = 76 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 077" {
    const p = input.parseKey(&.{77}).?;
    try std.testing.expectEqual(types.Key{ .char = 77 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 078" {
    const p = input.parseKey(&.{78}).?;
    try std.testing.expectEqual(types.Key{ .char = 78 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 079" {
    const p = input.parseKey(&.{79}).?;
    try std.testing.expectEqual(types.Key{ .char = 79 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 080" {
    const p = input.parseKey(&.{80}).?;
    try std.testing.expectEqual(types.Key{ .char = 80 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 081" {
    const p = input.parseKey(&.{81}).?;
    try std.testing.expectEqual(types.Key{ .char = 81 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 082" {
    const p = input.parseKey(&.{82}).?;
    try std.testing.expectEqual(types.Key{ .char = 82 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 083" {
    const p = input.parseKey(&.{83}).?;
    try std.testing.expectEqual(types.Key{ .char = 83 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 084" {
    const p = input.parseKey(&.{84}).?;
    try std.testing.expectEqual(types.Key{ .char = 84 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 085" {
    const p = input.parseKey(&.{85}).?;
    try std.testing.expectEqual(types.Key{ .char = 85 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 086" {
    const p = input.parseKey(&.{86}).?;
    try std.testing.expectEqual(types.Key{ .char = 86 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 087" {
    const p = input.parseKey(&.{87}).?;
    try std.testing.expectEqual(types.Key{ .char = 87 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 088" {
    const p = input.parseKey(&.{88}).?;
    try std.testing.expectEqual(types.Key{ .char = 88 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 089" {
    const p = input.parseKey(&.{89}).?;
    try std.testing.expectEqual(types.Key{ .char = 89 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 090" {
    const p = input.parseKey(&.{90}).?;
    try std.testing.expectEqual(types.Key{ .char = 90 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 091" {
    const p = input.parseKey(&.{91}).?;
    try std.testing.expectEqual(types.Key{ .char = 91 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 092" {
    const p = input.parseKey(&.{92}).?;
    try std.testing.expectEqual(types.Key{ .char = 92 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 093" {
    const p = input.parseKey(&.{93}).?;
    try std.testing.expectEqual(types.Key{ .char = 93 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 094" {
    const p = input.parseKey(&.{94}).?;
    try std.testing.expectEqual(types.Key{ .char = 94 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 095" {
    const p = input.parseKey(&.{95}).?;
    try std.testing.expectEqual(types.Key{ .char = 95 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 096" {
    const p = input.parseKey(&.{96}).?;
    try std.testing.expectEqual(types.Key{ .char = 96 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 097" {
    const p = input.parseKey(&.{97}).?;
    try std.testing.expectEqual(types.Key{ .char = 97 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 098" {
    const p = input.parseKey(&.{98}).?;
    try std.testing.expectEqual(types.Key{ .char = 98 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 099" {
    const p = input.parseKey(&.{99}).?;
    try std.testing.expectEqual(types.Key{ .char = 99 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 100" {
    const p = input.parseKey(&.{100}).?;
    try std.testing.expectEqual(types.Key{ .char = 100 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 101" {
    const p = input.parseKey(&.{101}).?;
    try std.testing.expectEqual(types.Key{ .char = 101 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 102" {
    const p = input.parseKey(&.{102}).?;
    try std.testing.expectEqual(types.Key{ .char = 102 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 103" {
    const p = input.parseKey(&.{103}).?;
    try std.testing.expectEqual(types.Key{ .char = 103 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 104" {
    const p = input.parseKey(&.{104}).?;
    try std.testing.expectEqual(types.Key{ .char = 104 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 105" {
    const p = input.parseKey(&.{105}).?;
    try std.testing.expectEqual(types.Key{ .char = 105 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 106" {
    const p = input.parseKey(&.{106}).?;
    try std.testing.expectEqual(types.Key{ .char = 106 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 107" {
    const p = input.parseKey(&.{107}).?;
    try std.testing.expectEqual(types.Key{ .char = 107 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 108" {
    const p = input.parseKey(&.{108}).?;
    try std.testing.expectEqual(types.Key{ .char = 108 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 109" {
    const p = input.parseKey(&.{109}).?;
    try std.testing.expectEqual(types.Key{ .char = 109 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 110" {
    const p = input.parseKey(&.{110}).?;
    try std.testing.expectEqual(types.Key{ .char = 110 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 111" {
    const p = input.parseKey(&.{111}).?;
    try std.testing.expectEqual(types.Key{ .char = 111 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 112" {
    const p = input.parseKey(&.{112}).?;
    try std.testing.expectEqual(types.Key{ .char = 112 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 113" {
    const p = input.parseKey(&.{113}).?;
    try std.testing.expectEqual(types.Key{ .char = 113 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 114" {
    const p = input.parseKey(&.{114}).?;
    try std.testing.expectEqual(types.Key{ .char = 114 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 115" {
    const p = input.parseKey(&.{115}).?;
    try std.testing.expectEqual(types.Key{ .char = 115 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 116" {
    const p = input.parseKey(&.{116}).?;
    try std.testing.expectEqual(types.Key{ .char = 116 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 117" {
    const p = input.parseKey(&.{117}).?;
    try std.testing.expectEqual(types.Key{ .char = 117 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 118" {
    const p = input.parseKey(&.{118}).?;
    try std.testing.expectEqual(types.Key{ .char = 118 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 119" {
    const p = input.parseKey(&.{119}).?;
    try std.testing.expectEqual(types.Key{ .char = 119 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 120" {
    const p = input.parseKey(&.{120}).?;
    try std.testing.expectEqual(types.Key{ .char = 120 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 121" {
    const p = input.parseKey(&.{121}).?;
    try std.testing.expectEqual(types.Key{ .char = 121 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 122" {
    const p = input.parseKey(&.{122}).?;
    try std.testing.expectEqual(types.Key{ .char = 122 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 123" {
    const p = input.parseKey(&.{123}).?;
    try std.testing.expectEqual(types.Key{ .char = 123 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 124" {
    const p = input.parseKey(&.{124}).?;
    try std.testing.expectEqual(types.Key{ .char = 124 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 125" {
    const p = input.parseKey(&.{125}).?;
    try std.testing.expectEqual(types.Key{ .char = 125 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 126" {
    const p = input.parseKey(&.{126}).?;
    try std.testing.expectEqual(types.Key{ .char = 126 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 127" {
    const p = input.parseKey(&.{127}).?;
    try std.testing.expectEqual(types.Key.backspace, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 128" {
    const p = input.parseKey(&.{128}).?;
    try std.testing.expectEqual(types.Key{ .char = 128 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 129" {
    const p = input.parseKey(&.{129}).?;
    try std.testing.expectEqual(types.Key{ .char = 129 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 130" {
    const p = input.parseKey(&.{130}).?;
    try std.testing.expectEqual(types.Key{ .char = 130 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 131" {
    const p = input.parseKey(&.{131}).?;
    try std.testing.expectEqual(types.Key{ .char = 131 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 132" {
    const p = input.parseKey(&.{132}).?;
    try std.testing.expectEqual(types.Key{ .char = 132 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 133" {
    const p = input.parseKey(&.{133}).?;
    try std.testing.expectEqual(types.Key{ .char = 133 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 134" {
    const p = input.parseKey(&.{134}).?;
    try std.testing.expectEqual(types.Key{ .char = 134 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 135" {
    const p = input.parseKey(&.{135}).?;
    try std.testing.expectEqual(types.Key{ .char = 135 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 136" {
    const p = input.parseKey(&.{136}).?;
    try std.testing.expectEqual(types.Key{ .char = 136 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 137" {
    const p = input.parseKey(&.{137}).?;
    try std.testing.expectEqual(types.Key{ .char = 137 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 138" {
    const p = input.parseKey(&.{138}).?;
    try std.testing.expectEqual(types.Key{ .char = 138 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 139" {
    const p = input.parseKey(&.{139}).?;
    try std.testing.expectEqual(types.Key{ .char = 139 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 140" {
    const p = input.parseKey(&.{140}).?;
    try std.testing.expectEqual(types.Key{ .char = 140 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 141" {
    const p = input.parseKey(&.{141}).?;
    try std.testing.expectEqual(types.Key{ .char = 141 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 142" {
    const p = input.parseKey(&.{142}).?;
    try std.testing.expectEqual(types.Key{ .char = 142 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 143" {
    const p = input.parseKey(&.{143}).?;
    try std.testing.expectEqual(types.Key{ .char = 143 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 144" {
    const p = input.parseKey(&.{144}).?;
    try std.testing.expectEqual(types.Key{ .char = 144 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 145" {
    const p = input.parseKey(&.{145}).?;
    try std.testing.expectEqual(types.Key{ .char = 145 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 146" {
    const p = input.parseKey(&.{146}).?;
    try std.testing.expectEqual(types.Key{ .char = 146 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 147" {
    const p = input.parseKey(&.{147}).?;
    try std.testing.expectEqual(types.Key{ .char = 147 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 148" {
    const p = input.parseKey(&.{148}).?;
    try std.testing.expectEqual(types.Key{ .char = 148 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 149" {
    const p = input.parseKey(&.{149}).?;
    try std.testing.expectEqual(types.Key{ .char = 149 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 150" {
    const p = input.parseKey(&.{150}).?;
    try std.testing.expectEqual(types.Key{ .char = 150 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 151" {
    const p = input.parseKey(&.{151}).?;
    try std.testing.expectEqual(types.Key{ .char = 151 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 152" {
    const p = input.parseKey(&.{152}).?;
    try std.testing.expectEqual(types.Key{ .char = 152 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 153" {
    const p = input.parseKey(&.{153}).?;
    try std.testing.expectEqual(types.Key{ .char = 153 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 154" {
    const p = input.parseKey(&.{154}).?;
    try std.testing.expectEqual(types.Key{ .char = 154 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 155" {
    const p = input.parseKey(&.{155}).?;
    try std.testing.expectEqual(types.Key{ .char = 155 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 156" {
    const p = input.parseKey(&.{156}).?;
    try std.testing.expectEqual(types.Key{ .char = 156 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 157" {
    const p = input.parseKey(&.{157}).?;
    try std.testing.expectEqual(types.Key{ .char = 157 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 158" {
    const p = input.parseKey(&.{158}).?;
    try std.testing.expectEqual(types.Key{ .char = 158 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 159" {
    const p = input.parseKey(&.{159}).?;
    try std.testing.expectEqual(types.Key{ .char = 159 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 160" {
    const p = input.parseKey(&.{160}).?;
    try std.testing.expectEqual(types.Key{ .char = 160 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 161" {
    const p = input.parseKey(&.{161}).?;
    try std.testing.expectEqual(types.Key{ .char = 161 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 162" {
    const p = input.parseKey(&.{162}).?;
    try std.testing.expectEqual(types.Key{ .char = 162 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 163" {
    const p = input.parseKey(&.{163}).?;
    try std.testing.expectEqual(types.Key{ .char = 163 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 164" {
    const p = input.parseKey(&.{164}).?;
    try std.testing.expectEqual(types.Key{ .char = 164 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 165" {
    const p = input.parseKey(&.{165}).?;
    try std.testing.expectEqual(types.Key{ .char = 165 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 166" {
    const p = input.parseKey(&.{166}).?;
    try std.testing.expectEqual(types.Key{ .char = 166 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 167" {
    const p = input.parseKey(&.{167}).?;
    try std.testing.expectEqual(types.Key{ .char = 167 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 168" {
    const p = input.parseKey(&.{168}).?;
    try std.testing.expectEqual(types.Key{ .char = 168 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 169" {
    const p = input.parseKey(&.{169}).?;
    try std.testing.expectEqual(types.Key{ .char = 169 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 170" {
    const p = input.parseKey(&.{170}).?;
    try std.testing.expectEqual(types.Key{ .char = 170 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 171" {
    const p = input.parseKey(&.{171}).?;
    try std.testing.expectEqual(types.Key{ .char = 171 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 172" {
    const p = input.parseKey(&.{172}).?;
    try std.testing.expectEqual(types.Key{ .char = 172 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 173" {
    const p = input.parseKey(&.{173}).?;
    try std.testing.expectEqual(types.Key{ .char = 173 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 174" {
    const p = input.parseKey(&.{174}).?;
    try std.testing.expectEqual(types.Key{ .char = 174 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 175" {
    const p = input.parseKey(&.{175}).?;
    try std.testing.expectEqual(types.Key{ .char = 175 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 176" {
    const p = input.parseKey(&.{176}).?;
    try std.testing.expectEqual(types.Key{ .char = 176 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 177" {
    const p = input.parseKey(&.{177}).?;
    try std.testing.expectEqual(types.Key{ .char = 177 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 178" {
    const p = input.parseKey(&.{178}).?;
    try std.testing.expectEqual(types.Key{ .char = 178 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 179" {
    const p = input.parseKey(&.{179}).?;
    try std.testing.expectEqual(types.Key{ .char = 179 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 180" {
    const p = input.parseKey(&.{180}).?;
    try std.testing.expectEqual(types.Key{ .char = 180 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 181" {
    const p = input.parseKey(&.{181}).?;
    try std.testing.expectEqual(types.Key{ .char = 181 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 182" {
    const p = input.parseKey(&.{182}).?;
    try std.testing.expectEqual(types.Key{ .char = 182 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 183" {
    const p = input.parseKey(&.{183}).?;
    try std.testing.expectEqual(types.Key{ .char = 183 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 184" {
    const p = input.parseKey(&.{184}).?;
    try std.testing.expectEqual(types.Key{ .char = 184 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 185" {
    const p = input.parseKey(&.{185}).?;
    try std.testing.expectEqual(types.Key{ .char = 185 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 186" {
    const p = input.parseKey(&.{186}).?;
    try std.testing.expectEqual(types.Key{ .char = 186 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 187" {
    const p = input.parseKey(&.{187}).?;
    try std.testing.expectEqual(types.Key{ .char = 187 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 188" {
    const p = input.parseKey(&.{188}).?;
    try std.testing.expectEqual(types.Key{ .char = 188 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 189" {
    const p = input.parseKey(&.{189}).?;
    try std.testing.expectEqual(types.Key{ .char = 189 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 190" {
    const p = input.parseKey(&.{190}).?;
    try std.testing.expectEqual(types.Key{ .char = 190 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 191" {
    const p = input.parseKey(&.{191}).?;
    try std.testing.expectEqual(types.Key{ .char = 191 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 192" {
    const p = input.parseKey(&.{192}).?;
    try std.testing.expectEqual(types.Key{ .char = 192 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 193" {
    const p = input.parseKey(&.{193}).?;
    try std.testing.expectEqual(types.Key{ .char = 193 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 194" {
    const p = input.parseKey(&.{194}).?;
    try std.testing.expectEqual(types.Key{ .char = 194 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 195" {
    const p = input.parseKey(&.{195}).?;
    try std.testing.expectEqual(types.Key{ .char = 195 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 196" {
    const p = input.parseKey(&.{196}).?;
    try std.testing.expectEqual(types.Key{ .char = 196 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 197" {
    const p = input.parseKey(&.{197}).?;
    try std.testing.expectEqual(types.Key{ .char = 197 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 198" {
    const p = input.parseKey(&.{198}).?;
    try std.testing.expectEqual(types.Key{ .char = 198 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 199" {
    const p = input.parseKey(&.{199}).?;
    try std.testing.expectEqual(types.Key{ .char = 199 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 200" {
    const p = input.parseKey(&.{200}).?;
    try std.testing.expectEqual(types.Key{ .char = 200 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 201" {
    const p = input.parseKey(&.{201}).?;
    try std.testing.expectEqual(types.Key{ .char = 201 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 202" {
    const p = input.parseKey(&.{202}).?;
    try std.testing.expectEqual(types.Key{ .char = 202 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 203" {
    const p = input.parseKey(&.{203}).?;
    try std.testing.expectEqual(types.Key{ .char = 203 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 204" {
    const p = input.parseKey(&.{204}).?;
    try std.testing.expectEqual(types.Key{ .char = 204 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 205" {
    const p = input.parseKey(&.{205}).?;
    try std.testing.expectEqual(types.Key{ .char = 205 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 206" {
    const p = input.parseKey(&.{206}).?;
    try std.testing.expectEqual(types.Key{ .char = 206 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 207" {
    const p = input.parseKey(&.{207}).?;
    try std.testing.expectEqual(types.Key{ .char = 207 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 208" {
    const p = input.parseKey(&.{208}).?;
    try std.testing.expectEqual(types.Key{ .char = 208 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 209" {
    const p = input.parseKey(&.{209}).?;
    try std.testing.expectEqual(types.Key{ .char = 209 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 210" {
    const p = input.parseKey(&.{210}).?;
    try std.testing.expectEqual(types.Key{ .char = 210 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 211" {
    const p = input.parseKey(&.{211}).?;
    try std.testing.expectEqual(types.Key{ .char = 211 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 212" {
    const p = input.parseKey(&.{212}).?;
    try std.testing.expectEqual(types.Key{ .char = 212 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 213" {
    const p = input.parseKey(&.{213}).?;
    try std.testing.expectEqual(types.Key{ .char = 213 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 214" {
    const p = input.parseKey(&.{214}).?;
    try std.testing.expectEqual(types.Key{ .char = 214 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 215" {
    const p = input.parseKey(&.{215}).?;
    try std.testing.expectEqual(types.Key{ .char = 215 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 216" {
    const p = input.parseKey(&.{216}).?;
    try std.testing.expectEqual(types.Key{ .char = 216 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 217" {
    const p = input.parseKey(&.{217}).?;
    try std.testing.expectEqual(types.Key{ .char = 217 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 218" {
    const p = input.parseKey(&.{218}).?;
    try std.testing.expectEqual(types.Key{ .char = 218 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 219" {
    const p = input.parseKey(&.{219}).?;
    try std.testing.expectEqual(types.Key{ .char = 219 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 220" {
    const p = input.parseKey(&.{220}).?;
    try std.testing.expectEqual(types.Key{ .char = 220 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 221" {
    const p = input.parseKey(&.{221}).?;
    try std.testing.expectEqual(types.Key{ .char = 221 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 222" {
    const p = input.parseKey(&.{222}).?;
    try std.testing.expectEqual(types.Key{ .char = 222 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 223" {
    const p = input.parseKey(&.{223}).?;
    try std.testing.expectEqual(types.Key{ .char = 223 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 224" {
    const p = input.parseKey(&.{224}).?;
    try std.testing.expectEqual(types.Key{ .char = 224 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 225" {
    const p = input.parseKey(&.{225}).?;
    try std.testing.expectEqual(types.Key{ .char = 225 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 226" {
    const p = input.parseKey(&.{226}).?;
    try std.testing.expectEqual(types.Key{ .char = 226 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 227" {
    const p = input.parseKey(&.{227}).?;
    try std.testing.expectEqual(types.Key{ .char = 227 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 228" {
    const p = input.parseKey(&.{228}).?;
    try std.testing.expectEqual(types.Key{ .char = 228 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 229" {
    const p = input.parseKey(&.{229}).?;
    try std.testing.expectEqual(types.Key{ .char = 229 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 230" {
    const p = input.parseKey(&.{230}).?;
    try std.testing.expectEqual(types.Key{ .char = 230 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 231" {
    const p = input.parseKey(&.{231}).?;
    try std.testing.expectEqual(types.Key{ .char = 231 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 232" {
    const p = input.parseKey(&.{232}).?;
    try std.testing.expectEqual(types.Key{ .char = 232 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 233" {
    const p = input.parseKey(&.{233}).?;
    try std.testing.expectEqual(types.Key{ .char = 233 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 234" {
    const p = input.parseKey(&.{234}).?;
    try std.testing.expectEqual(types.Key{ .char = 234 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 235" {
    const p = input.parseKey(&.{235}).?;
    try std.testing.expectEqual(types.Key{ .char = 235 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 236" {
    const p = input.parseKey(&.{236}).?;
    try std.testing.expectEqual(types.Key{ .char = 236 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 237" {
    const p = input.parseKey(&.{237}).?;
    try std.testing.expectEqual(types.Key{ .char = 237 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 238" {
    const p = input.parseKey(&.{238}).?;
    try std.testing.expectEqual(types.Key{ .char = 238 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 239" {
    const p = input.parseKey(&.{239}).?;
    try std.testing.expectEqual(types.Key{ .char = 239 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 240" {
    const p = input.parseKey(&.{240}).?;
    try std.testing.expectEqual(types.Key{ .char = 240 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 241" {
    const p = input.parseKey(&.{241}).?;
    try std.testing.expectEqual(types.Key{ .char = 241 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 242" {
    const p = input.parseKey(&.{242}).?;
    try std.testing.expectEqual(types.Key{ .char = 242 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 243" {
    const p = input.parseKey(&.{243}).?;
    try std.testing.expectEqual(types.Key{ .char = 243 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 244" {
    const p = input.parseKey(&.{244}).?;
    try std.testing.expectEqual(types.Key{ .char = 244 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 245" {
    const p = input.parseKey(&.{245}).?;
    try std.testing.expectEqual(types.Key{ .char = 245 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 246" {
    const p = input.parseKey(&.{246}).?;
    try std.testing.expectEqual(types.Key{ .char = 246 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 247" {
    const p = input.parseKey(&.{247}).?;
    try std.testing.expectEqual(types.Key{ .char = 247 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 248" {
    const p = input.parseKey(&.{248}).?;
    try std.testing.expectEqual(types.Key{ .char = 248 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 249" {
    const p = input.parseKey(&.{249}).?;
    try std.testing.expectEqual(types.Key{ .char = 249 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 250" {
    const p = input.parseKey(&.{250}).?;
    try std.testing.expectEqual(types.Key{ .char = 250 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 251" {
    const p = input.parseKey(&.{251}).?;
    try std.testing.expectEqual(types.Key{ .char = 251 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 252" {
    const p = input.parseKey(&.{252}).?;
    try std.testing.expectEqual(types.Key{ .char = 252 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 253" {
    const p = input.parseKey(&.{253}).?;
    try std.testing.expectEqual(types.Key{ .char = 253 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 254" {
    const p = input.parseKey(&.{254}).?;
    try std.testing.expectEqual(types.Key{ .char = 254 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}

test "input byte 255" {
    const p = input.parseKey(&.{255}).?;
    try std.testing.expectEqual(types.Key{ .char = 255 }, p.key);
    try std.testing.expectEqual(@as(usize, 1), p.consumed);
}
