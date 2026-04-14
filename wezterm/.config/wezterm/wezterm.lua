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
-- config.bold_brightens_ansi_colors = false
config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
}

-- Colorscheme
local colorscheme = require("colors")
config.colors = colorscheme.colors
-- config.color_scheme = "zenbones"
-- config.color_scheme = "zenbones_dark"
-- config.color_scheme = "Zenburn (base16)"
-- config.color_scheme = "Seoul256 Light (Gogh)" -- Awfull contrast
-- config.color_scheme = "Silk Light (base16)" -- Eye burnt
-- config.color_scheme = "Solarized (light) (terminal.sexy)"
config.default_cursor_style = "BlinkingBar"

require("wayland_gnome").apply_to_config(config)
require("keys").apply_to_config(config)
require("appearance").apply(config, colorscheme, font, font_size)
require("format_tab_title")

wezterm.on("update-status", function(window, pane)
    local tab = window:active_tab()
    local panes = tab:panes_with_info()
    local is_zoomed = #panes > 1 and panes[1].is_zoomed

    if is_zoomed then
        window:set_right_status(wezterm.format({
            { Foreground = { Color = "#ffaa00" } },
            { Text = " ZOOMED " },
        }))
    else
        window:set_right_status("")
    end
end)
return config
