local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Common
config.initial_cols = 160
config.initial_rows = 42
config.scrollback_lines = 100000
config.automatically_reload_config = false
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

-- Colorscheme
local colorscheme = require("colors")
config.colors = colorscheme.colors
config.default_cursor_style = "BlinkingBar"

-- Fontconfig
local font_size = 11
local font = { family = "JetBrains Mono", weight = "Light" }
config.font = wezterm.font(font)
config.font_size = font_size
config.bold_brightens_ansi_colors = false

require("wayland_gnome").apply_to_config(config)
require("keys").apply_to_config(config)
require("format_tab_tittle")

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

--- Right status bar
wezterm.on("update-right-status", function(window, _)
    local want = window:leader_is_active()
    local overrides = window:get_config_overrides() or {}

    -- turn on while leader is held
    if want and overrides.show_tab_index_in_tab_bar ~= true then
        window:set_config_overrides(overrides)
    end

    -- turn off when leader released (nil = revert to base config)
    if not want and overrides.show_tab_index_in_tab_bar ~= nil then
        window:set_config_overrides(overrides)
    end

    local hint = want and "Leader Active " or " "
    -- Optional: a tiny visual hint in the right status when Leader is down
    window:set_right_status(wezterm.format({
        { Foreground = { Color = colorscheme.palette.normal } },
        { Text = hint },
    }))
end)

return config
