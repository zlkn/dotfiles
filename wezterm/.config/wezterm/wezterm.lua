local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Colorscheme
local colors = require("colors")
-- config.color_scheme = "My"
-- config.color_schemes = { ["My"] = colors }
-- FIXME: This is a workaround for the colorscheme not being applied properly
-- config.colors = {
--     tab_bar = {
--         -- The color of the inactive tab bar edge/divider
--         inactive_tab_edge = colors.background,
--     },
-- }
config.colors = colors
config.default_cursor_style = "BlinkingBar"

-- Fontconfig
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
config.integrated_title_button_style = "Gnome"

-- Window config
config.initial_cols = 160
config.initial_rows = 42
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = NONE
config.window_padding = { left = 15, right = 5, top = 5, bottom = 5 }
config.window_frame = {
    inactive_titlebar_bg = colors.background,
    active_titlebar_bg = colors.background,
    inactive_titlebar_fg = colors.background,
    active_titlebar_fg = colors.background,
    inactive_titlebar_border_bottom = colors.background,
    active_titlebar_border_bottom = colors.background,
    button_fg = colors.background,
    button_bg = colors.background,
    button_hover_fg = colors.background,

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
config.tab_max_width = 25

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

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local SSH_DOMAIN = wezterm.nerdfonts.md_collage
    local SERVER_ICON = wezterm.nerdfonts.md_access_point
    local SHELL_ICON = wezterm.nerdfonts.md_console_line
    local KUBECTL_ICON = wezterm.nerdfonts.md_kubernetes
    local REMOTE_ICON = wezterm.nerdfonts.md_cloud
    local DASHBOARD_ICON = wezterm.nerdfonts.md_gauge
    local TEXT_EDITOR_ICON = wezterm.nerdfonts.linux_neovim
    local INSPECT_ICON = wezterm.nerdfonts.md_magnify
    local TRANSFER_ICON = wezterm.nerdfonts.md_flash
    local PYTHON_ICON = wezterm.nerdfonts.md_language_python
    local TASK_PENDING_ICON = wezterm.nerdfonts.md_run
    local SUDO_ICON = wezterm.nerdfonts.md_shield_half_full
    local LAZYGIT_ICON = wezterm.nerdfonts.fa_github_alt
    local TERRAFORM_ICON = wezterm.nerdfonts.md_terraform
    local GCLOUD_ICON = wezterm.nerdfonts.md_google_cloud

    local background = colors.background

    local foreground = "#808080"

    if tab.is_active then
        foreground = colors.foreground
    elseif hover then
        foreground = "#707070"
    end

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    local exec_name = ""
    local title_with_icon = ""

    if tab.active_pane.foreground_process_name == "" then
        if tab.active_pane.domain_name == "local" then
            title_with_icon = TASK_PENDING_ICON .. ".."
        else
            title_with_icon = SSH_DOMAIN
        end
    else
        exec_name = get_process_name(tab.active_pane.foreground_process_name)

        if exec_name == "wezterm-gui" then
            title_with_icon = SERVER_ICON .. " WezTerm"
        elseif exec_name == "sudo" then
            title_with_icon = SUDO_ICON .. " "
        elseif in_array(exec_name, { "sh", "bash", "zsh", "fish" }) then
            title_with_icon = SHELL_ICON .. " "
        elseif exec_name == "kubectl" then
            title_with_icon = KUBECTL_ICON .. " "
        elseif in_array(exec_name, { "ssh", "sftp" }) then
            title_with_icon = REMOTE_ICON .. " "
        elseif in_array(exec_name, { "btm", "top", "htop", "ntop" }) then
            title_with_icon = DASHBOARD_ICON .. " "
        elseif exec_name == "nvim" then
            title_with_icon = TEXT_EDITOR_ICON
        elseif exec_name == "vim" then
            title_with_icon = TEXT_EDITOR_ICON
        elseif exec_name == "nano" then
            title_with_icon = TEXT_EDITOR_ICON
        elseif in_array(exec_name, { "bat", "less", "moar" }) then
            title_with_icon = INSPECT_ICON
        elseif in_array(exec_name, { "fzf", "peco" }) then
            title_with_icon = INSPECT_ICON
        elseif exec_name == "man" then
            title_with_icon = INSPECT_ICON
        elseif in_array(exec_name, { "aria2c", "curl", "wget", "yt-dlp", "rsync" }) then
            title_with_icon = TRANSFER_ICON
        elseif in_array(exec_name, { "python", "Python", "python3" }) then
            title_with_icon = PYTHON_ICON
        elseif in_array(exec_name, { "lazygit", "git" }) then
            title_with_icon = LAZYGIT_ICON
        elseif exec_name == "terraform" then
            title_with_icon = TERRAFORM_ICON
        elseif exec_name == "gcloud" then
            title_with_icon = GCLOUD_ICON
        else
            title_with_icon = TASK_PENDING_ICON
        end
    end

    title = " " .. title_with_icon .. " " .. title .. " "
    title = wezterm.truncate_right(title, max_width - 3)

    return wezterm.format({
        { Background = { Color = background } },
        { Foreground = { Color = background } },

        { Text = "" },

        { Foreground = { Color = foreground } },
        { Text = title },

        { Foreground = { Color = background } },
        { Text = "" },
    })
end)

-- Create a status bar on the top right that shows the current workspace and date
-- wezterm.on("update-right-status", function(window, pane)
-- 	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S")
--
-- 	-- Make it italic and underlined
-- 	window:set_right_status(wezterm.format({
-- 		{ Attribute = { Underline = "Single" } },
-- 		{ Attribute = { Italic = true } },
-- 		{ Attribute = { Intensity = "Bold" } },
-- 		{ Background = { colors.background } },
-- 		{ Foreground = { colors.foreground } },
-- 		{ Text = window:active_workspace() },
-- 		{ Text = "   " },
-- 		{ Text = date },
-- 	}))
-- end)

config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"

-- config.leader = { key = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    { key = "x", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
    { key = "l", mods = "CTRL", action = wezterm.action.ShowLauncher },
    { key = "-", mods = "CTRL", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "\\", mods = "CTRL", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "h", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
    {
        key = "g",
        mods = "CTRL|SHIFT",
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
        mods = "CTRL",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

return config
