local colors = {
    foreground = "#313113",
    background = "#f8f8f8",
    cursor_bg = "#20bbfc",
    cursor_fg = "#424242",
    cursor_border = "#20bbfc",
    selection_bg = "#b6d6fd",
    selection_fg = "#313131",
    scrollbar_thumb = "#313131",
    split = "#f8f8f8",

    -- Before 16 colors, there were 8 colors: black, red, green, yellow, blue, magenta, cyan, and white.
    -- The other 8 colors were added as bright variants of these
    ansi = { "#313131", "#c30771", "#10a778", "#a66f00", "#008ec4", "#523c79", "#20a5ba", "#d9d9d9" },
    brights = { "#212121", "#fb007a", "#5fd7af", "#f39c12", "#20bbfc", "#6855de", "#4fb8cc", "#a1a1a1" },

    indexed = {},

    copy_mode_active_highlight_bg = { Color = "#424242" },
    copy_mode_active_highlight_fg = { Color = "#523c79" },
    copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
    copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

    quick_select_label_bg = { Color = "peru" },
    quick_select_label_fg = { Color = "#ffffff" },
    quick_select_match_bg = { Color = "#b6d6fd" },
    quick_select_match_fg = { Color = "#424242" },

    tab_bar = { inactive_tab_edge = "#f8f8f8" },
}

return colors
