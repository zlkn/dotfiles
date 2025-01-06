local pallete = {
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
        lightGray = "#f8f8f8",
        darkGray = "#424242",
        pureWhite = "#ffffff",
    },
}

local function get_values(t)
    local values = {}
    for _, value in pairs(t) do
        table.insert(values, value)
    end
    print(values)
    return values
end

local colors = {

    indexed = {},

    foreground = pallete.ansi.black,
    background = pallete.extra.lightGray,
    cursor_bg = pallete.brights.blue,
    cursor_fg = pallete.extra.darkGray,
    cursor_border = pallete.brights.blue,
    selection_bg = pallete.extra.cornflowerBlue,
    selection_fg = pallete.ansi.black,
    scrollbar_thumb = pallete.ansi.black,
    split = pallete.brights.white,

    -- Before 16 colors, there were 8 colors: black, red, green, yellow, blue, magenta, cyan, and white.
    -- The other 8 colors were added as bright variants of these
    ansi = get_values(pallete.ansi),
    brights = get_values(pallete.brights),

    copy_mode_active_highlight_bg = { Color = pallete.extra.darkGray },
    copy_mode_active_highlight_fg = { Color = pallete.ansi.magenta },
    copy_mode_inactive_highlight_bg = { Color = pallete.ansi.green },
    copy_mode_inactive_highlight_fg = { AnsiColor = pallete.extra.pureWhite },

    quick_select_label_bg = { Color = pallete.ansi.green },
    quick_select_label_fg = { Color = pallete.extra.pureWhite },
    quick_select_match_bg = { Color = pallete.extra.cornflowerBlue },
    quick_select_match_fg = { Color = pallete.extra.darkGray },

    tab_bar = { inactive_tab_edge = pallete.extra.lightGray },
}

return {
    palete = pallete,
    colors = colors,
}
