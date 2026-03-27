const std = @import("std");

pub const Locale = @import("i18n/locale.zig").Locale;
pub const Key = @import("i18n/translations.zig").Key;
pub const init = @import("i18n/translations.zig").init;
pub const deinit = @import("i18n/translations.zig").deinit;
pub const get = @import("i18n/translations.zig").get;
pub const format = @import("i18n/translations.zig").format;
pub const setLocale = @import("i18n/translations.zig").setLocale;
