local palette = {
    ansi = {
        black = "#313131",
        red = "#c30771",
        green = "#10a778",
        yellow = "#a66f00",
        blue = "#008ec4",
        magenta = "#523c79",
        cyan = "#20a5ba",
        white = "#d9d9d9",
    },
    brights = {
        black = "#212121",
        red = "#fb007a",
        green = "#5fd7af",
        yellow = "#f39c12",
        blue = "#20bbfc",
        magenta = "#6855de",
        cyan = "#4fb8cc",
        white = "#a1a1a1",
    },
    extra = {
        cornflowerBlue = "#b6d6fd",
        darkGray = "#424242",
        lightGray = "#f8f8f8",
        pureWhite = "#ffffff",
    },
}

local colors = {

    indexed = {},

    foreground = palette.ansi.black,
    background = palette.extra.lightGray,

    cursor_bg = palette.brights.blue,
    cursor_fg = palette.extra.darkGray,
    cursor_border = palette.brights.blue,

    selection_bg = palette.extra.cornflowerBlue,
    selection_fg = palette.ansi.black,

    scrollbar_thumb = palette.ansi.black,

    split = palette.brights.white,

    -- Before 16 colors, there were 8 colors: black, red, green, yellow, blue, magenta, cyan, and white.
    -- The other 8 colors were added as bright variants of these
    ansi = {
        palette.ansi.black,
        palette.ansi.red,
        palette.ansi.green,
        palette.ansi.yellow,
        palette.ansi.blue,
        palette.ansi.magenta,
        palette.ansi.cyan,
        palette.ansi.white,
    },
    brights = {
        palette.brights.black,
        palette.brights.red,
        palette.brights.green,
        palette.brights.yellow,
        palette.brights.blue,
        palette.brights.magenta,
        palette.brights.cyan,
        palette.brights.white,
    },

    copy_mode_active_highlight_bg = { Color = palette.extra.cornflowerBlue },
    copy_mode_active_highlight_fg = { Color = palette.ansi.black },
    copy_mode_inactive_highlight_bg = { Color = palette.ansi.green },
    copy_mode_inactive_highlight_fg = { Color = palette.ansi.black },

    quick_select_label_bg = { Color = palette.ansi.green },
    quick_select_label_fg = { Color = palette.brights.black },
    quick_select_match_bg = { Color = palette.extra.cornflowerBlue },
    quick_select_match_fg = { Color = palette.brights.black },

    tab_bar = { inactive_tab_edge = palette.extra.lightGray },
}

return {
    palette = palette,
    colors = colors,
}
