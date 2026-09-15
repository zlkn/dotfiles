#!/usr/bin/env python3

import string
import sys
from pathlib import Path

# Single source of truth for every generated theme file below.
# aqua ships two variants: aqua_day (light) and aqua_night (dark).

AQUA_DAY = {
    "normal": "#424242",
    "cursor": "#20bbfc",
    # "background": "#f0eee6",
    # "background": "#f2efef",
    # "background": "#f2f2f2",
    "background": "#ebebed",
    # "background": "#faf9f9",
    # "background": "#e7e6e3",
    # "selection": "#d1dfe1",
    # "selection": "#f2efef",
    "selection": "#dfdfe1",

    "ansi_black": "#d1d1d1",
    "ansi_red": "#b81a6b",
    "ansi_green": "#1e763c",
    "ansi_yellow": "#8d5b00",
    "ansi_blue": "#015493",
    "ansi_magenta": "#75228e",
    "ansi_cyan": "#007474",
    "ansi_white": "#424242",

    "bright_black": "#57606a",
    "bright_red": "#b81a6b",
    "bright_green": "#1e763c",
    "bright_yellow": "#8d5b00",
    "bright_blue": "#015493",
    "bright_magenta": "#75228e",
    "bright_cyan": "#007474",
    # "bright_white": "#123369",
    # "bright_white": "#242424",
    # "bright_white": "#0e3044",
    # "bright_white": "#085157",
    "bright_white": "#00425c",

    "extra_bg1": "#f2f2f2",
    "extra_bg2": "#e7e7e7",
    "extra_pencil_gray": "#9d9d9d",
    "extra_gray0": "#dfdfe1",
    "extra_gray1": "#d1d1d1",
    "extra_gray2": "#a1a1a1",
    "extra_gray3": "#57606a",
    "extra_gray4": "#d1dfe1",
    "extra_gray5": "#b4b4b6",
    "extra_white": "#6f8396",
}

AQUA_NIGHT = {
    "normal": "#c9ccce",
    "cursor": "#20bbfc",
    "background": "#15191b",
    "selection": "#262b2e",

    "ansi_black": "#2f3538",
    "ansi_red": "#e2689b",
    "ansi_green": "#5fb87a",
    "ansi_yellow": "#d0a058",
    "ansi_blue": "#57a6d8",
    "ansi_magenta": "#b07cc6",
    "ansi_cyan": "#48b3af",
    "ansi_white": "#c9ccce",

    "bright_black": "#7a858c",
    "bright_red": "#e2689b",
    "bright_green": "#5fb87a",
    "bright_yellow": "#d0a058",
    "bright_blue": "#57a6d8",
    "bright_magenta": "#b07cc6",
    "bright_cyan": "#48b3af",
    "bright_white": "#86d0e0",

    "extra_bg1": "#1d2225",
    "extra_bg2": "#101315",
    "extra_pencil_gray": "#5c6468",
    "extra_gray0": "#262b2e",
    "extra_gray1": "#2f3538",
    "extra_gray2": "#4a5257",
    "extra_gray3": "#7a858c",
    "extra_gray4": "#2c3a3d",
    "extra_gray5": "#3c4245",
    "extra_white": "#93a3ae",
}

VARIANTS = {
    "aqua_day": AQUA_DAY,
    "aqua_night": AQUA_NIGHT,
}

NVIM_LUA_DIR = "../vim/.config/nvim/lua"
WEZTERM_DIR = "../wezterm/.config/wezterm"

# language=lua
PALETTE_LUA = """\
-- !!! Generated do not edit manually !!!
local palette = {
    variant = "${variant}",
    normal = "${normal}",
    cursor = "${cursor}",
    background = "${background}",
    selection = "${selection}",
    ansi = {
        black   = "${ansi_black}",
        red     = "${ansi_red}",
        green   = "${ansi_green}",
        yellow  = "${ansi_yellow}",
        blue    = "${ansi_blue}",
        magenta = "${ansi_magenta}",
        cyan    = "${ansi_cyan}",
        white   = "${ansi_white}",
    },
    brights = {
        black   = "${bright_black}",
        red     = "${bright_red}",
        green   = "${bright_green}",
        yellow  = "${bright_yellow}",
        blue    = "${bright_blue}",
        magenta = "${bright_magenta}",
        cyan    = "${bright_cyan}",
        white   = "${bright_white}",
    },
    extra = {
        bg1        = "${extra_bg1}",
        bg2        = "${extra_bg2}",
        pencilGray = "${extra_pencil_gray}",
        gray0      = "${extra_gray0}",
        gray1      = "${extra_gray1}",
        gray2      = "${extra_gray2}",
        gray3      = "${extra_gray3}",
        gray4      = "${extra_gray4}",
        gray5      = "${extra_gray5}",
        white      = "${extra_white}",
    },
}
return palette
"""

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


def render(template, variant, palette):
    return string.Template(template).substitute(palette, variant=variant)


def main():
    root = Path(__file__).resolve().parent

    for variant, palette in VARIANTS.items():
        palette_dests = [
            f"{NVIM_LUA_DIR}/palette_{variant}.lua",
            f"{WEZTERM_DIR}/palette_{variant}.lua",
        ]

        for dst in palette_dests:
            print(f"Populate palette {dst}")
            (root / dst).write_text(render(PALETTE_LUA, variant, palette))

        wezterm_scheme = f"{WEZTERM_DIR}/colors/{variant}.toml"
        print(f"Populate wezterm scheme {wezterm_scheme}")
        (root / wezterm_scheme).parent.mkdir(parents=True, exist_ok=True)
        (root / wezterm_scheme).write_text(render(WEZTERM_TOML, variant, palette))


if __name__ == "__main__":
    sys.exit(main())
