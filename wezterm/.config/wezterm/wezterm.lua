local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Common
config.initial_cols = 160
config.initial_rows = 42
config.scrollback_lines = 100000
config.automatically_reload_config = false
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

-- Fontconfig
local font_size = 11
local font = { family = "JetBrains Mono", weight = "Light" }
config.font = wezterm.font(font)
config.font_size = font_size
config.bold_brightens_ansi_colors = false

-- Colorscheme
local colorscheme = require("colors")
config.colors = colorscheme.colors
config.default_cursor_style = "BlinkingBar"

require("wayland_gnome").apply_to_config(config)
require("keys").apply_to_config(config)
require("appearance").apply(config, colorscheme, font, font_size)
require("format_tab_tittle")

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
