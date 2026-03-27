const std = @import("std");

pub const Locale = enum {
    en,
    tr,

    pub fn fromStr(s: []const u8) ?Locale {
        if (std.mem.eql(u8, s, "en")) return .en;
        if (std.mem.eql(u8, s, "tr")) return .tr;
        return null;
    }

    pub fn toString(self: Locale) []const u8 {
        return switch (self) {
            .en => "en",
            .tr => "tr",
        };
    }
};
