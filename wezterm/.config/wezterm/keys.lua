local wezterm = require("wezterm")
local mod = {}

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
