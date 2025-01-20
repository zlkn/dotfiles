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
config.warn_about_missing_glyphs = false
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.font_size = 11.0
config.font = wezterm.font({
    family = "JetBrains Mono",
    weight = "Light",
})

-- Gnome integration
local wayland_gnome = require("wayland_gnome")
wayland_gnome.apply_to_config(config)

-- Window config
config.initial_cols = 160
config.initial_rows = 42
config.window_close_confirmation = "NeverPrompt"
-- config.integrated_title_buttons = { "Close" }
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "NONE"
config.window_padding = { left = 15, right = 5, top = 5, bottom = 5 }
config.window_frame = {
    -- Add split line on stacked wezterm
    border_left_width = "0.12cell",
    border_right_width = "0.12cell",
    border_bottom_height = "0.1cell",
    border_top_height = "0.1cell",
    border_left_color = colorscheme.palette.extra.borderGray,
    border_right_color = colorscheme.palette.extra.borderGray,
    border_bottom_color = colorscheme.palette.extra.borderGray,
    border_top_color = colorscheme.palette.extra.borderGray,

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

    font_size = 11,
    font = wezterm.font({
        family = "JetBrains Mono",
        weight = "Regular",
    }),
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

local function in_array(value, array)
    for _, val in ipairs(array) do
        if val == value then
            return true
        end
    end

    return false
end

local function get_process_name(str)
    return str:gsub("^.*[/\\]", ""):gsub("%.exe$", "")
end

local function get_icon(tab)
    local icon = ""

    if tab.active_pane.foreground_process_name == "" then
        if tab.active_pane.domain_name == "local" then
            icon = wezterm.nerdfonts.md_run .. ".."
        else
            icon = wezterm.nerdfonts.md_collage
        end
    else
        local exec_name = get_process_name(tab.active_pane.foreground_process_name)
        print("exec_name: " .. exec_name)

        if exec_name == "wezterm-gui" then
            icon = wezterm.nerdfonts.md_access_point .. " WezTerm"
        elseif exec_name == "sudo" then
            icon = wezterm.nerdfonts.md_shield_half_full .. " "
        elseif in_array(exec_name, { "sh", "bash", "zsh", "fish" }) then
            icon = wezterm.nerdfonts.md_console_line .. " "
        elseif exec_name == "kubectl" then
            icon = wezterm.nerdfonts.md_kubernetes .. " "
        elseif in_array(exec_name, { "ssh", "sftp" }) then
            icon = wezterm.nerdfonts.md_cloud .. " "
        elseif in_array(exec_name, { "btm", "top", "htop", "ntop" }) then
            icon = wezterm.nerdfonts.md_gauge .. " "
        elseif exec_name == "nvim" then
            icon = wezterm.nerdfonts.linux_neovim
        elseif exec_name == "vim" then
            icon = wezterm.nerdfonts.linux_neovim
        elseif exec_name == "nano" then
            icon = wezterm.nerdfonts.linux_neovim
        elseif in_array(exec_name, { "bat", "less", "moar" }) then
            icon = wezterm.nerdfonts.md_magnify
        elseif in_array(exec_name, { "fzf", "peco" }) then
            icon = wezterm.nerdfonts.md_magnify
        elseif exec_name == "man" then
            icon = wezterm.nerdfonts.md_magnify
        elseif in_array(exec_name, { "aria2c", "curl", "wget", "yt-dlp", "rsync" }) then
            icon = wezterm.nerdfonts.md_flash
        elseif in_array(exec_name, { "python", "Python", "python3" }) then
            icon = wezterm.nerdfonts.md_language_python
        elseif in_array(exec_name, { "lazygit", "git" }) then
            icon = wezterm.nerdfonts.fa_github_alt
        elseif exec_name == "terraform" then
            icon = wezterm.nerdfonts.md_terraform
        elseif exec_name == "gcloud" then
            icon = wezterm.nerdfonts.md_google_cloud
        else
            icon = wezterm.nerdfonts.md_run
        end

        icon = icon .. " "
    end

    return icon
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local foreground = colorscheme.colors.foreground

    if not tab.is_active then
        foreground = colorscheme.palette.extra.mediumGray
    elseif hover then
        foreground = colorscheme.palette.extra.mediumGray
    end

    local title = " " .. get_icon(tab) .. tab_title(tab) .. " "

    return wezterm.format({
        { Background = { Color = colorscheme.colors.background } },
        { Foreground = { Color = foreground } },
        { Text = title },
    })
end)

config.leader = { key = "RightAlt", mods = "NONE", timeout_milliseconds = 1000 }
config.keys = {
    { key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(-1) },
    { key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(1) },
    { key = "w", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = "x", mods = "ALT", action = wezterm.action.ActivateCopyMode },
    { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
    { key = "-", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "\\", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "t", mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
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

return config
