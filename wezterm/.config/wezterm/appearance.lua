local wezterm = require("wezterm")

local mod = {}

-- window_frame is not part of the color scheme, so its colors need resolving by hand
local function scheme(config)
    local builtin = wezterm.color.get_builtin_schemes()[config.color_scheme]
    if builtin then
        return builtin
    end
    return wezterm.color.load_scheme(wezterm.config_dir .. "/colors/" .. config.color_scheme .. ".toml")
end

function mod.apply(config, font, font_size)
    local colors = scheme(config)
    local background = colors.background
    local border = colors.ansi[1]
    local foreground = colors.ansi[8]

    -- Command Palette
    config.command_palette_font_size = font_size
    config.command_palette_bg_color = border
    config.command_palette_fg_color = foreground

    -- Char select
    config.char_select_font_size = font_size
    config.char_select_bg_color = border
    config.char_select_fg_color = foreground

    config.window_frame = {
        font_size = font_size,
        font = wezterm.font(font),

        -- Add split line on stacked wezterm
        border_left_width = "0.12cell",
        border_right_width = "0.12cell",
        border_bottom_height = "0.1cell",
        border_top_height = "0.1cell",
        border_left_color = border,
        border_right_color = border,
        border_bottom_color = border,
        border_top_color = border,

        -- Match tabbar colors with colorscheme
        inactive_titlebar_bg = background,
        active_titlebar_bg = background,
        inactive_titlebar_fg = background,
        active_titlebar_fg = background,
        inactive_titlebar_border_bottom = background,
        active_titlebar_border_bottom = background,
        button_fg = background,
        button_bg = background,
        button_hover_fg = background,
    }

    --- Tabbar config
    config.show_tab_index_in_tab_bar = true
    config.show_close_tab_button_in_tabs = false
    config.switch_to_last_active_tab_when_closing_tab = true
    config.show_new_tab_button_in_tab_bar = false
end

return mod
