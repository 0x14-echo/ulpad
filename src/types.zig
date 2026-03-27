pub const ScreenSize = struct {
    rows: usize,
    cols: usize,
};

pub const Viewport = struct {
    top_line: usize = 0,
    left_col: usize = 0,
};

pub const Selection = struct {
    start: usize,
    end: usize,
};

pub const EditorMode = enum {
    normal,
    find,
    replace,
};

pub const Key = union(enum) {
    char: u8,
    ctrl: u8,
    enter,
    backspace,
    delete,
    escape,
    tab,
    arrow_up,
    arrow_down,
    arrow_left,
    arrow_right,
    home,
    end,
    page_up,
    page_down,
};
