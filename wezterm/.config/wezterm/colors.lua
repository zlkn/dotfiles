local palette = require("palette")
local colors = {

    indexed = {},

    foreground = palette.ansi.black,
    background = palette.extra.backgroundGray,

    cursor_bg = "#20bbfc", -- palette.brights.blue,
    -- cursor_fg = palette .. black, -- palette.extra.darkGray,
    cursor_border = palette.brights.white, -- palette.brights.blue,

    -- selection_bg = palette.extra.cornflowerBlue,
    selection_bg = palette.extra.gray0,
    selection_fg = palette.ansi.black,

    scrollbar_thumb = palette.ansi.black,

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
    copy_mode_active_highlight_fg = { Color = palette.ansi.magenta },
    copy_mode_inactive_highlight_bg = { Color = palette.ansi.green },
    copy_mode_inactive_highlight_fg = { Color = palette.brights.white },

    quick_select_label_bg = { Color = palette.extra.pineGreen },
    quick_select_label_fg = { Color = palette.extra.pureWhite },
    quick_select_match_bg = { Color = palette.extra.cornflowerBlue },
    quick_select_match_fg = { Color = palette.brights.black },

    tab_bar = {
        background = palette.extra.backgroundGray,
        inactive_tab_edge = palette.extra.backgroundGray,
        active_tab = {
            bg_color = palette.extra.backgroundGray,
            fg_color = palette.ansi.black,
        },

        inactive_tab = {
            bg_color = palette.extra.backgroundGray,
            fg_color = palette.ansi.black,
        },
    },
}

return {
    palette = palette,
    colors = colors,
}
