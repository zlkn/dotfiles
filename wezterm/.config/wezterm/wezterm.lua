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

return config
