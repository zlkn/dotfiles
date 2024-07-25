local wezterm = require("wezterm")

local config = wezterm.config_builder()

local colors = require("colors") -- Adjust the path as needed

config.color_scheme = "My"
config.color_schemes = { ["My"] = colors }

--config.color_scheme = "PencilLight"

config.default_cursor_style = "BlinkingBar"

-- config.freetype_load_flags = "NO_HINTING"
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.font_size = 11.0
config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "Light",
})

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "Gnome"
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

	border_left_width = "0.2cell",
	border_right_width = "0.2cell",
	border_bottom_height = "0.1cell",
	border_top_height = "0.1cell",
	border_left_color = "black",
	border_right_color = "black",
	border_bottom_color = "black",
	border_top_color = "black",

	font_size = 11,
	font = wezterm.font({
		family = "JetBrains Mono",
		weight = "Light",
	}),
}

config.initial_cols = 160
config.initial_rows = 42

config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 25
config.colors = { tab_bar = { inactive_tab_edge = colors.background } }
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

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
	local TEXT_EDITOR_ICON = wezterm.nerdfonts.md_pen
	local INSPECT_ICON = wezterm.nerdfonts.md_magnify
	local TRANSFER_ICON = wezterm.nerdfonts.md_flash
	local PYTHON_ICON = wezterm.nerdfonts.md_language_python
	local TASK_PENDING_ICON = wezterm.nerdfonts.md_run
	local SUDO_ICON = wezterm.nerdfonts.md_shield_half_full

	local background = colors.background

	local foreground = "#808080"
	local edge_background = background
	local edge_foreground = background

	if tab.is_active then
		foreground = "#212121"
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
		else
			title_with_icon = TASK_PENDING_ICON
		end
	end

	title = " " .. title_with_icon .. " " .. title .. " "
	title = wezterm.truncate_right(title, max_width - 3)

	return wezterm.format({
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },

		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },

		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	})
end)

config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"

local wayland_gnome = require("wayland_gnome")
wayland_gnome.apply_to_config(config)

-- config.leader = { key = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "l", mods = "LEADER", action = wezterm.action.ShowLauncher },
	{ key = "-", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
}

return config
