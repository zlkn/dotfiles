local wezterm = require("wezterm")

local mod = {}

function mod.apply(config, colorscheme, font, font_size)
    -- Command Palette
    config.command_palette_font_size = font_size
    config.command_palette_bg_color = colorscheme.palette.extra.gray1
    config.command_palette_fg_color = colorscheme.colors.foreground

    -- Char select
    config.char_select_font_size = font_size
    config.char_select_bg_color = colorscheme.palette.extra.gray1
    config.char_select_fg_color = colorscheme.colors.foreground

    -- Window config
    config.window_background_gradient = {
        orientation = "Vertical",
        colors = {
            colorscheme.palette.extra.bg1,
            colorscheme.palette.extra.bg2,
        },
    }

    config.window_frame = {
        font_size = font_size,
        font = wezterm.font(font),

        -- Add split line on stacked wezterm
        border_left_width = "0.12cell",
        border_right_width = "0.12cell",
        border_bottom_height = "0.1cell",
        border_top_height = "0.1cell",
        border_left_color = colorscheme.palette.extra.gray1,
        border_right_color = colorscheme.palette.extra.gray1,
        border_bottom_color = colorscheme.palette.extra.gray1,
        border_top_color = colorscheme.palette.extra.gray1,

        -- Match tabbar colors with colorscheme
        inactive_titlebar_bg = colorscheme.colors.background,
        active_titlebar_bg = colorscheme.colors.background,
        inactive_titlebar_fg = colorscheme.colors.background,
        active_titlebar_fg = colorscheme.colors.background,
        inactive_titlebar_border_bottom = colorscheme.colors.background,
        active_titlebar_border_bottom = colorscheme.colors.background,
        button_fg = colorscheme.colors.background,
        button_bg = colorscheme.colors.background,
        button_hover_fg = colorscheme.colors.background,
    }

    --- Tabbar config
    config.show_tab_index_in_tab_bar = true
    config.show_close_tab_button_in_tabs = false
    config.switch_to_last_active_tab_when_closing_tab = true
    config.show_new_tab_button_in_tab_bar = false
end

return mod
