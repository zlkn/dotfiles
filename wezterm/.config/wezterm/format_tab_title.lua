local wezterm = require("wezterm")
local colorscheme = require("colors")

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
        ["sh"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.ansi.black },
        ["bash"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.ansi.black },
        ["zsh"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.ansi.black },
        ["fish"] = { symbol = wezterm.nerdfonts.md_console_line, color = colorscheme.palette.ansi.white },
        ["kubectl"] = { symbol = wezterm.nerdfonts.md_kubernetes, color = colorscheme.palette.brights.blue },
        ["k9s"] = { symbol = wezterm.nerdfonts.md_kubernetes, color = colorscheme.palette.brights.blue },
        ["ssh"] = { symbol = wezterm.nerdfonts.md_cloud, color = colorscheme.palette.brights.black },
        ["sftp"] = { symbol = wezterm.nerdfonts.md_cloud, color = colorscheme.palette.brights.white },
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
        ["lazygit"] = { symbol = wezterm.nerdfonts.fa_github_alt, color = colorscheme.palette.brights.magenta },
        ["git"] = { symbol = wezterm.nerdfonts.fa_github_alt, color = colorscheme.palette.ansi.magenta },
        ["terraform"] = { symbol = wezterm.nerdfonts.md_terraform, color = colorscheme.palette.brights.magenta },
        ["gcloud"] = { symbol = wezterm.nerdfonts.md_google_cloud, color = colorscheme.palette.ansi.cyan },
        ["make"] = { symbol = wezterm.nerdfonts.cod_run_all, color = colorscheme.palette.brights.green },
    }

    local icon = { symbol = wezterm.nerdfonts.md_collage, color = colorscheme.palette.ansi.white }
    if tab.active_pane.foreground_process_name == "" then
        return icon
    end

    local exec_name = get_process_name(tab.active_pane.foreground_process_name)
    print("exec_name: " .. exec_name .. " tab: " .. tab.active_pane.foreground_process_name)

    local icon_cfg = icons[exec_name]

    if icon_cfg then
        icon.symbol = icons[exec_name].symbol or wezterm.nerdfonts.md_run
        icon.color = icons[exec_name].color or colorscheme.palette.ansi.black
    end

    return icon
end

---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
    local foreground = colorscheme.colors.foreground
    local background = colorscheme.colors.background

    if tab.is_active then
        background = colorscheme.palette.ansi.black
    elseif hover then
        background = colorscheme.palette.ansi.black
    end

    local icon = get_icon(tab)
    local title = tab_title(tab)

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

        { Background = { Color = colorscheme.colors.background } },
        { Foreground = { Color = background } },
        { Text = "" },
    })
end)
