local palette = require("palette")
local fg = palette.ansi.white
local colors = {

    indexed = {},

    foreground = fg,
    background = palette.extra.bg1,

    cursor_fg = palette.cursor,
    cursor_bg = palette.cursor,
    cursor_border = palette.brights.white,

    selection_bg = palette.extra.gray1,
    selection_fg = fg,

    scrollbar_thumb = fg,

    split = palette.extra.gray2,

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
    copy_mode_active_highlight_fg = { Color = fg },

    copy_mode_inactive_highlight_bg = { Color = palette.ansi.green },
    copy_mode_inactive_highlight_fg = { Color = fg },

    quick_select_label_bg = { Color = palette.brights.green },
    quick_select_label_fg = { Color = palette.extra.pureWhite },
    quick_select_match_bg = { Color = palette.extra.cornflowerBlue },
    quick_select_match_fg = { Color = fg },

    tab_bar = {
        background = palette.extra.bg1,
        inactive_tab_edge = palette.extra.bg1,
        active_tab = {
            bg_color = palette.extra.bg1,
            fg_color = fg,
        },

        inactive_tab = {
            bg_color = palette.extra.bg1,
            fg_color = fg,
        },
    },
}

return {
    palette = palette,
    colors = colors,
}
