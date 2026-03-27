const std = @import("std");
const Locale = @import("locale.zig").Locale;

pub const Key = enum {
    // Status messages
    status_saved,
    status_not_found,
    status_found_at,
    status_replace_one,
    status_replace_all,
    status_no_matches,
    status_no_further_matches,
    status_canceled,
    status_unsaved_changes,
    status_press_q_to_quit,

    // Prompt labels
    prompt_find,
    prompt_replace_find,
    prompt_replace_with,
    prompt_save_as,
    prompt_replace_action,

    // Mode labels
    mode_normal,
    mode_find,
    mode_replace,

    // Shortcuts
    shortcut_save,
    shortcut_quit,
    shortcut_find,
    shortcut_replace,
    shortcut_copy,
    shortcut_cut,
    shortcut_paste,
    shortcut_select_all,
    shortcut_mark,

    // Help
    help_title,
    help_save_desc,
    help_quit_desc,
    help_find_desc,
    help_replace_desc,
    help_copy_desc,
    help_cut_desc,
    help_paste_desc,
    help_select_desc,
    help_mark_desc,

    // Error
    error_write_failed,
    error_read_failed,

    // Match info
    match_count,
    match_viewing,
};

const Translations = std.AutoHashMap(Locale, std.AutoHashMap(Key, []const u8));

var translations: Translations = undefined;

pub fn init(allocator: std.mem.Allocator) !void {
    translations = Translations.init(allocator);

    // English translations
    var en_map = std.AutoHashMap(Key, []const u8).init(allocator);
    try en_map.put(.status_saved, "Saved {s}");
    try en_map.put(.status_not_found, "'{s}' not found");
    try en_map.put(.status_found_at, "Found '{s}' at {d}");
    try en_map.put(.status_replace_one, "Replaced one match");
    try en_map.put(.status_replace_all, "Replaced {d} matches");
    try en_map.put(.status_no_matches, "No matches found");
    try en_map.put(.status_no_further_matches, "No further matches");
    try en_map.put(.status_canceled, "Canceled");
    try en_map.put(.status_unsaved_changes, "Unsaved changes. Press Ctrl-Q again to quit.");
    try en_map.put(.status_press_q_to_quit, "Press Ctrl-Q to quit");

    try en_map.put(.prompt_find, "Find: ");
    try en_map.put(.prompt_replace_find, "Replace find: ");
    try en_map.put(.prompt_replace_with, "Replace with: ");
    try en_map.put(.prompt_save_as, "Save as: ");
    try en_map.put(.prompt_replace_action, "Enter=replace one | a=replace all | Esc=cancel");

    try en_map.put(.mode_normal, "NORMAL");
    try en_map.put(.mode_find, "FIND");
    try en_map.put(.mode_replace, "REPLACE");

    try en_map.put(.shortcut_save, "Ctrl-S");
    try en_map.put(.shortcut_quit, "Ctrl-Q");
    try en_map.put(.shortcut_find, "Ctrl-F");
    try en_map.put(.shortcut_replace, "Ctrl-H");
    try en_map.put(.shortcut_copy, "Ctrl-C");
    try en_map.put(.shortcut_cut, "Ctrl-X");
    try en_map.put(.shortcut_paste, "Ctrl-V");
    try en_map.put(.shortcut_select_all, "Ctrl-A");
    try en_map.put(.shortcut_mark, "Ctrl-B");

    try en_map.put(.help_title, "Help");
    try en_map.put(.help_save_desc, "Save file");
    try en_map.put(.help_quit_desc, "Quit editor");
    try en_map.put(.help_find_desc, "Find text");
    try en_map.put(.help_replace_desc, "Find and replace");
    try en_map.put(.help_copy_desc, "Copy selection");
    try en_map.put(.help_cut_desc, "Cut selection");
    try en_map.put(.help_paste_desc, "Paste clipboard");
    try en_map.put(.help_select_desc, "Select all text");
    try en_map.put(.help_mark_desc, "Toggle selection");

    try en_map.put(.error_write_failed, "Write failed");
    try en_map.put(.error_read_failed, "Read failed");

    try en_map.put(.match_count, "{d} matches");
    try en_map.put(.match_viewing, "{d}/{d} matches");

    try translations.put(.en, en_map);

    // Turkish translations
    var tr_map = std.AutoHashMap(Key, []const u8).init(allocator);
    try tr_map.put(.status_saved, "Kaydedildi: {s}");
    try tr_map.put(.status_not_found, "'{s}' bulunamadi");
    try tr_map.put(.status_found_at, "'{s}' {d} konumunda bulundu");
    try tr_map.put(.status_replace_one, "Bir eslesme degistirildi");
    try tr_map.put(.status_replace_all, "{d} eslesme degistirildi");
    try tr_map.put(.status_no_matches, "Eslesme bulunamadi");
    try tr_map.put(.status_no_further_matches, "Baska eslesme bulunamadi");
    try tr_map.put(.status_canceled, "Iptal edildi");
    try tr_map.put(.status_unsaved_changes, "Kaydedilmemis degisiklikler. Cikmak icin Ctrl-Q'ya tekrar basin.");
    try tr_map.put(.status_press_q_to_quit, "Cikmak icin Ctrl-Q basin");

    try tr_map.put(.prompt_find, "Ara: ");
    try tr_map.put(.prompt_replace_find, "Aranacak: ");
    try tr_map.put(.prompt_replace_with, "Degistirilecek: ");
    try tr_map.put(.prompt_save_as, "Farkli kaydet: ");
    try tr_map.put(.prompt_replace_action, "Enter=bir degistir | a=tumu degistir | Esc=iptal");

    try tr_map.put(.mode_normal, "NORMAL");
    try tr_map.put(.mode_find, "ARA");
    try tr_map.put(.mode_replace, "DEGISTIR");

    try tr_map.put(.shortcut_save, "Ctrl-S");
    try tr_map.put(.shortcut_quit, "Ctrl-Q");
    try tr_map.put(.shortcut_find, "Ctrl-F");
    try tr_map.put(.shortcut_replace, "Ctrl-H");
    try tr_map.put(.shortcut_copy, "Ctrl-C");
    try tr_map.put(.shortcut_cut, "Ctrl-X");
    try tr_map.put(.shortcut_paste, "Ctrl-V");
    try tr_map.put(.shortcut_select_all, "Ctrl-A");
    try tr_map.put(.shortcut_mark, "Ctrl-B");

    try tr_map.put(.help_title, "Yardim");
    try tr_map.put(.help_save_desc, "Dosyayi kaydet");
    try tr_map.put(.help_quit_desc, "Editorden cik");
    try tr_map.put(.help_find_desc, "Metin ara");
    try tr_map.put(.help_replace_desc, "Bul ve degistir");
    try tr_map.put(.help_copy_desc, "Secimi kopyala");
    try tr_map.put(.help_cut_desc, "Secimi kes");
    try tr_map.put(.help_paste_desc, "Panodan yapistir");
    try tr_map.put(.help_select_desc, "Tum metni sec");
    try tr_map.put(.help_mark_desc, "Secim modu ac/kapa");

    try tr_map.put(.error_write_failed, "Yazma basarisiz");
    try tr_map.put(.error_read_failed, "Okuma basarisiz");

    try tr_map.put(.match_count, "{d} eslesme");
    try tr_map.put(.match_viewing, "{d}/{d} eslesme");

    try translations.put(.tr, tr_map);
}

pub fn deinit() void {
    var it = translations.iterator();
    while (it.next()) |entry| {
        entry.value_ptr.deinit();
    }
    translations.deinit();
}

pub fn get(locale: Locale, key: Key) []const u8 {
    if (translations.get(locale)) |map| {
        if (map.get(key)) |value| {
            return value;
        }
    }
    // Fallback to English
    if (translations.get(.en)) |map| {
        if (map.get(key)) |value| {
            return value;
        }
    }
    // Fallback to key name
    return @tagName(key);
}

pub fn format(allocator: std.mem.Allocator, locale: Locale, key: Key, args: anytype) ![]u8 {
    const template = get(locale, key);
    // For now, just return the template without formatting
    // TODO: Implement proper runtime formatting
    _ = args;
    return allocator.dupe(u8, template);
}

pub fn setLocale(allocator: std.mem.Allocator, new_locale: Locale) !void {
    _ = allocator;
    _ = new_locale;
    // In a real implementation, this would update a global locale state
    // For now, the caller needs to pass the locale to each get() call
}
