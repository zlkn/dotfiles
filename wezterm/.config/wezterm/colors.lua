local palette = {
    ansi = {
        black = "#212121",
        red = "#c30771",
        green = "#10a778",
        yellow = "#d79921",
        blue = "#0550ae",
        magenta = "#523c79",
        cyan = "#008ec4",
        white = "#9d9d9d",
    },
    brights = {
        black = "#1f1f1f",
        red = "#fb007a",
        green = "#10b97a",
        yellow = "#f39c12",
        blue = "#005fd7",
        magenta = "#871094",
        cyan = "#20bbfc",
        white = "#f1f1f1",
    },
    rainbow = {
        red = "#cc241d",
        orange = "#d65d0e",
        yellow = "#d79921",
        green = "#689d6a",
        cyan = "#a89984",
        blue = "#458588",
        violet = "#b16286",
    },
    extra = {
        cyan = "#007474",
        -- green = "#10a778",
        PineGreen = "#27745c",
        LightSeaGreen = "#5fd7af",
        MoonStonecyan = "#4fb8cc",
        brown = "#a66f00",
        yellow = "#d7af5f",
        cornflowerBlue = "#b6d6fd",
        darkGray = "#424242",
        borderGray = "#f1f1f1",
        mediumGray = "#808080",
        pencilGray = "#9d9d9d",
        lightGray = "#f0f0f0",
        pureWhite = "#ffffff",
    },
}

local colors = {

    indexed = {},

    foreground = palette.ansi.black,
    background = palette.extra.borderGray,

    cursor_bg = "#20bbfc", -- palette.brights.blue,
    -- cursor_fg = palette .. black, -- palette.extra.darkGray,
    -- cursor_border = "#20bbfc", -- palette.brights.blue,

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
