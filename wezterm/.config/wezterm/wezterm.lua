local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = false

-- Colorscheme
local colorscheme = require("colors")
config.colors = colorscheme.colors
config.default_cursor_style = "BlinkingBar"
config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 1.0,
}

-- Fontconfig
local font_size = 12
local font = { family = "JetBrains Mono", weight = "Regular" }
config.font = wezterm.font(font)
config.warn_about_missing_glyphs = false
config.font_size = font_size

-- Command Palette
config.command_palette_font_size = font_size
config.command_palette_bg_color = colorscheme.palette.extra.gray1
config.command_palette_fg_color = colorscheme.colors.foreground

-- Char select
config.char_select_font_size = font_size
config.char_select_bg_color = colorscheme.palette.extra.gray1
config.char_select_fg_color = colorscheme.colors.foreground

-- Gnome integration
local wayland_gnome = require("wayland_gnome")
wayland_gnome.apply_to_config(config)
config.window_background_gradient = {
    orientation = "Vertical",
    colors = {
        colorscheme.palette.extra.bg1,
        colorscheme.palette.extra.bg2,
    },
}

-- Window config
config.initial_cols = 160
config.initial_rows = 42
config.scrollback_lines = 100000
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "TITLE|RESIZE"
config.window_padding = { left = 10, right = 10, top = 2, bottom = 2 }
config.window_frame = {
    font_size = font_size,
    -- font = wezterm.font("JetBrains Mono"),
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
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.switch_to_last_active_tab_when_closing_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 999

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

local function get_process_name(str)
    return str:gsub("^.*[/\\]", ""):gsub("%.exe$", "")
end

local function get_icon(tab)
    local icons = {
        ["wezterm-gui"] = { symbol = wezterm.nerdfonts.md_access_point .. " WezTerm" },
        -- TODO: I'd like to use this icon as additional extra symbol in tab
        ["sudo"] = { symbol = wezterm.nerdfonts.md_shield_half_full },
        ["ncdu"] = { symbol = wezterm.nerdfonts.fa_pie_chart, color = colorscheme.palette.brights.magenta },
        ["sh"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.extra.darkGray },
        ["bash"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.extra.darkGray },
        ["zsh"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.extra.darkGray },
        ["fish"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.extra.darkGray },
        ["kubectl"] = { symbol = wezterm.nerdfonts.md_kubernetes, color = colorscheme.palette.extra.brightBlue },
        ["k9s"] = { symbol = wezterm.nerdfonts.md_kubernetes, color = colorscheme.palette.extra.brightBlue },
        ["ssh"] = { symbol = wezterm.nerdfonts.md_cloud, color = colorscheme.palette.extra.deepTeal },
        ["sftp"] = { symbol = wezterm.nerdfonts.md_cloud, color = colorscheme.palette.extra.deepTeal },
        ["btm"] = { symbol = wezterm.nerdfonts.md_gauge, color = colorscheme.palette.brights.black },
        ["top"] = { symbol = wezterm.nerdfonts.md_gauge, color = colorscheme.palette.brights.black },
        ["htop"] = { symbol = wezterm.nerdfonts.md_gauge, color = colorscheme.palette.brights.black },
        ["ntop"] = { symbol = wezterm.nerdfonts.md_gauge, color = colorscheme.palette.brights.black },
        ["nvim"] = { symbol = wezterm.nerdfonts.linux_neovim, color = colorscheme.palette.brights.green },
        ["vim"] = { symbol = wezterm.nerdfonts.linux_neovim },
        ["nano"] = { symbol = wezterm.nerdfonts.linux_neovim },
        ["bat"] = { symbol = wezterm.nerdfonts.md_magnify },
        ["less"] = { symbol = wezterm.nerdfonts.md_magnify },
        ["moar"] = { symbol = wezterm.nerdfonts.md_magnify },
        ["fzf"] = { symbol = wezterm.nerdfonts.md_magnify },
        ["peco"] = { symbol = wezterm.nerdfonts.md_magnify },
        ["man"] = { symbol = wezterm.nerdfonts.md_magnify },
        ["aria2c"] = { symbol = wezterm.nerdfonts.md_flash },
        ["curl"] = { symbol = wezterm.nerdfonts.md_flash },
        ["wget"] = { symbol = wezterm.nerdfonts.md_flash },
        ["yt-dlp"] = { symbol = wezterm.nerdfonts.md_flash },
        ["rsync"] = { symbol = wezterm.nerdfonts.md_flash },
        ["python"] = { symbol = wezterm.nerdfonts.md_language_python, color = colorscheme.palette.ansi.yellow },
        ["Python"] = { symbol = wezterm.nerdfonts.md_language_python, color = colorscheme.palette.ansi.yellow },
        ["python3"] = { symbol = wezterm.nerdfonts.md_language_python, color = colorscheme.palette.ansi.yellow },
        ["python3.13"] = { symbol = wezterm.nerdfonts.md_language_python, color = colorscheme.palette.ansi.yellow },
        ["lazygit"] = { symbol = wezterm.nerdfonts.fa_github_alt, color = colorscheme.palette.brights.black },
        ["git"] = { symbol = wezterm.nerdfonts.fa_github_alt, color = colorscheme.palette.brights.black },
        ["terraform"] = { symbol = wezterm.nerdfonts.md_terraform, color = colorscheme.palette.brights.magenta },
        ["gcloud"] = { symbol = wezterm.nerdfonts.md_google_cloud, color = colorscheme.palette.extra.darkBlue },
        ["make"] = { symbol = wezterm.nerdfonts.cod_run_all, color = colorscheme.palette.extra.green },
    }

    local icon = { symbol = wezterm.nerdfonts.md_collage, color = colorscheme.palette.extra.darkGray }
    if tab.active_pane.foreground_process_name == "" then
        return icon
    end

    local exec_name = get_process_name(tab.active_pane.foreground_process_name)
    icon.symbol = icons[exec_name].symbol or wezterm.nerdfonts.md_run
    icon.color = icons[exec_name].color or colorscheme.palette.extra.darkGray
    -- print("exec_name: " .. exec_name .. " tab: " .. tab.active_pane.foreground_process_name)

    return icon
end

---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
    local foreground = colorscheme.colors.foreground
    local background = colorscheme.colors.background

    if tab.is_active then
        background = colorscheme.palette.extra.gray1
    elseif hover then
        background = colorscheme.palette.extra.gray1
    end

    local icon = get_icon(tab)
    local title = tab_title(tab)
    -- print("title: " .. title)

    return wezterm.format({
        { Background = { Color = colorscheme.colors.background } },
        { Foreground = { Color = background } },
        { Text = "" },

        { Background = { Color = background } },
        { Foreground = { Color = icon.color } },
        { Text = icon.symbol .. " " },

        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },

        { Background = { Color = colorscheme.colors.backgrounbackgroundGrayd } },
        { Foreground = { Color = background } },
        { Text = "" },
    })
end)

-- Toggle tab indices while Leader is held
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
        { Foreground = { Color = colorscheme.palette.ansi.black } },
        { Text = hint },
    }))
end)

-- Keybindings
config.leader = { key = "RightAlt", mods = "NONE", timeout_milliseconds = 1000 }
config.keys = {
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ShowTabNavigator },
    { key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(-1) },
    { key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(1) },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = "x", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },
    { key = "-", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    {
        key = "\\",
        mods = "ALT",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "g",
        mods = "ALT",
        action = wezterm.action.SpawnCommandInNewTab({
            label = "LazyGit",
            args = { "lazygit" },
            domain = "CurrentPaneDomain",
        }),
    },
}

for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
    direction_keys = {
        move = { "h", "j", "k", "l" },
        resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
    },
    modifiers = {
        move = "ALT",
        resize = "META",
    },
    log_level = "info",
})

return config
