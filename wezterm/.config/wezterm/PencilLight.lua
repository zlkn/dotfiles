local my_colors = {
	foreground = "#eeeeec",
	background = "#f1f1f1",
	cursor_bg = "#20bbfc",
	cursor_fg = "#424242",
	cursor_border = "#20bbfc",
	selection_bg = "#b6d6fd",
	selection_fg = "#424242",
	scrollbar_thumb = "#222222",
	split = "#444444",

	ansi = { "#212121", "#c30771", "#10a778", "#a89c14", "#008ec4", "#523c79", "#20a5ba", "#ffaaaa" },
	brights = { "#424242", "#fb007a", "#5fd7af", "#f3e430", "#20bbfc", "#6855de", "#4fb8cc", "#ffaaaa" },

	indexed = {},

	copy_mode_active_highlight_bg = { Color = "#000000" },
	copy_mode_active_highlight_fg = { AnsiColor = "Black" },
	copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
	copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

	quick_select_label_bg = { Color = "peru" },
	quick_select_label_fg = { Color = "#ffffff" },
	quick_select_match_bg = { AnsiColor = "Navy" },
	quick_select_match_fg = { Color = "#ffffff" },
}
-- wezterm.log_info(my_colors)
-- config.color_scheme = "My"
-- config.color_schemes = { ["My"] = my_colors }

-- config.colors = my_colors