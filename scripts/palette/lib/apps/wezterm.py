from palettes import Palette
from ..render import write

WEZTERM_DIR = "wezterm/.config/wezterm"

# language=toml
WEZTERM_TOML = """\
# !!! Generated do not edit manually !!!
[metadata]
name = "${variant}"

[colors]
foreground = "${ansi_white}"
background = "${background}"

cursor_fg = "${normal}"
cursor_bg = "${cursor}"
cursor_border = "${bright_white}"

selection_fg = "${ansi_white}"
selection_bg = "${extra_gray1}"

scrollbar_thumb = "${ansi_white}"
split = "${selection}"

# Before 16 colors, there were 8 colors: black, red, green, yellow, blue,
# magenta, cyan, and white. The other 8 were added as their bright variants.
ansi = [
    "${ansi_black}",
    "${ansi_red}",
    "${ansi_green}",
    "${ansi_yellow}",
    "${ansi_blue}",
    "${ansi_magenta}",
    "${ansi_cyan}",
    "${ansi_white}",
]
brights = [
    "${bright_black}",
    "${bright_red}",
    "${bright_green}",
    "${bright_yellow}",
    "${bright_blue}",
    "${bright_magenta}",
    "${bright_cyan}",
    "${bright_white}",
]

copy_mode_active_highlight_bg = { Color = "${ansi_green}" }
copy_mode_active_highlight_fg = { Color = "${extra_bg1}" }
copy_mode_inactive_highlight_bg = { Color = "${ansi_green}" }
copy_mode_inactive_highlight_fg = { Color = "${ansi_black}" }

quick_select_label_bg = { Color = "${bright_green}" }
quick_select_label_fg = { Color = "${extra_bg1}" }
quick_select_match_bg = { Color = "${ansi_cyan}" }
quick_select_match_fg = { Color = "${ansi_black}" }

# Keep the retro tab bar seamless with the terminal background.
[colors.tab_bar]
background = "${background}"
inactive_tab_edge = "${background}"

[colors.tab_bar.active_tab]
bg_color = "${background}"
fg_color = "${ansi_white}"

[colors.tab_bar.inactive_tab]
bg_color = "${background}"
fg_color = "${ansi_white}"
"""


def generate(variant: str, palette: Palette) -> None:
    write(f"{WEZTERM_DIR}/colors/{variant}.toml", WEZTERM_TOML, variant, palette)
