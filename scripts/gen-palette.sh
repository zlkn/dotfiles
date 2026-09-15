#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

# Single source of truth for every generated theme file below.
# aqua ships two variants: aqua_day (light) and aqua_night (dark).

aqua_day() {
  NORMAL="#424242"
  CURSOR="#20bbfc"
  # BACKGROUND="#f0eee6"
  # BACKGROUND="#f2efef"
  # BACKGROUND="#f2f2f2"
  BACKGROUND="#ebebed"
  # BACKGROUND="#faf9f9"
  # BACKGROUND="#e7e6e3"
  # SELECTION="#d1dfe1"
  # SELECTION="#f2efef"
  SELECTION="#dfdfe1"

  ANSI_BLACK="#d1d1d1"
  ANSI_RED="#b81a6b"
  ANSI_GREEN="#1e763c"
  ANSI_YELLOW="#8d5b00"
  ANSI_BLUE="#015493"
  ANSI_MAGENTA="#75228e"
  ANSI_CYAN="#007474"
  ANSI_WHITE="#424242"

  BRIGHT_BLACK="#57606a"
  BRIGHT_RED="#b81a6b"
  BRIGHT_GREEN="#1e763c"
  BRIGHT_YELLOW="#8d5b00"
  BRIGHT_BLUE="#015493"
  BRIGHT_MAGENTA="#75228e"
  BRIGHT_CYAN="#007474"
  # BRIGHT_WHITE="#123369"
  # BRIGHT_WHITE="#242424"
  # BRIGHT_WHITE="#0e3044"
  # BRIGHT_WHITE="#085157"
  BRIGHT_WHITE="#00425c"

  EXTRA_BG1="#f2f2f2"
  EXTRA_BG2="#e7e7e7"
  EXTRA_PENCIL_GRAY="#9d9d9d"
  EXTRA_GRAY0="#dfdfe1"
  EXTRA_GRAY1="#d1d1d1"
  EXTRA_GRAY2="#a1a1a1"
  EXTRA_GRAY3="#57606a"
  EXTRA_GRAY4="#d1dfe1"
  EXTRA_GRAY5="#b4b4b6"
  EXTRA_WHITE="#6f8396"
}

aqua_night() {
  NORMAL="#c9ccce"
  CURSOR="#20bbfc"
  BACKGROUND="#15191b"
  SELECTION="#262b2e"

  ANSI_BLACK="#2f3538"
  ANSI_RED="#e2689b"
  ANSI_GREEN="#5fb87a"
  ANSI_YELLOW="#d0a058"
  ANSI_BLUE="#57a6d8"
  ANSI_MAGENTA="#b07cc6"
  ANSI_CYAN="#48b3af"
  ANSI_WHITE="#c9ccce"

  BRIGHT_BLACK="#7a858c"
  BRIGHT_RED="#e2689b"
  BRIGHT_GREEN="#5fb87a"
  BRIGHT_YELLOW="#d0a058"
  BRIGHT_BLUE="#57a6d8"
  BRIGHT_MAGENTA="#b07cc6"
  BRIGHT_CYAN="#48b3af"
  BRIGHT_WHITE="#86d0e0"

  EXTRA_BG1="#1d2225"
  EXTRA_BG2="#101315"
  EXTRA_PENCIL_GRAY="#5c6468"
  EXTRA_GRAY0="#262b2e"
  EXTRA_GRAY1="#2f3538"
  EXTRA_GRAY2="#4a5257"
  EXTRA_GRAY3="#7a858c"
  EXTRA_GRAY4="#2c3a3d"
  EXTRA_GRAY5="#3c4245"
  EXTRA_WHITE="#93a3ae"
}

declare -a VARIANTS=(
  "aqua_day"
  "aqua_night"
)

NVIM_LUA_DIR="../vim/.config/nvim/lua"
WEZTERM_DIR="../wezterm/.config/wezterm"

for variant in "${VARIANTS[@]}";
do
  "${variant}"

  declare -a palette_dests=(
    "${NVIM_LUA_DIR}/palette_${variant}.lua"
    "${WEZTERM_DIR}/palette_${variant}.lua"
  )

  for dst in "${palette_dests[@]}";
  do
    echo "Populate palette ${dst}"

    # language=lua
    cat << EOD > "${dst}"
-- !!! Generated do not edit manually !!!
local palette = {
    variant = "${variant}",
    normal = "${NORMAL}",
    cursor = "${CURSOR}",
    background = "${BACKGROUND}",
    selection = "${SELECTION}",
    ansi = {
        black   = "${ANSI_BLACK}",
        red     = "${ANSI_RED}",
        green   = "${ANSI_GREEN}",
        yellow  = "${ANSI_YELLOW}",
        blue    = "${ANSI_BLUE}",
        magenta = "${ANSI_MAGENTA}",
        cyan    = "${ANSI_CYAN}",
        white   = "${ANSI_WHITE}",
    },
    brights = {
        black   = "${BRIGHT_BLACK}",
        red     = "${BRIGHT_RED}",
        green   = "${BRIGHT_GREEN}",
        yellow  = "${BRIGHT_YELLOW}",
        blue    = "${BRIGHT_BLUE}",
        magenta = "${BRIGHT_MAGENTA}",
        cyan    = "${BRIGHT_CYAN}",
        white   = "${BRIGHT_WHITE}",
    },
    extra = {
        bg1        = "${EXTRA_BG1}",
        bg2        = "${EXTRA_BG2}",
        pencilGray = "${EXTRA_PENCIL_GRAY}",
        gray0      = "${EXTRA_GRAY0}",
        gray1      = "${EXTRA_GRAY1}",
        gray2      = "${EXTRA_GRAY2}",
        gray3      = "${EXTRA_GRAY3}",
        gray4      = "${EXTRA_GRAY4}",
        gray5      = "${EXTRA_GRAY5}",
        white      = "${EXTRA_WHITE}",
    },
}
return palette
EOD

  done

  wezterm_scheme="${WEZTERM_DIR}/colors/${variant}.toml"
  echo "Populate wezterm scheme ${wezterm_scheme}"
  mkdir -p "$(dirname "${wezterm_scheme}")"

  # language=toml
  cat << EOD > "${wezterm_scheme}"
# !!! Generated do not edit manually !!!
[metadata]
name = "${variant}"

[colors]
foreground = "${ANSI_WHITE}"
background = "${BACKGROUND}"

cursor_fg = "${NORMAL}"
cursor_bg = "${CURSOR}"
cursor_border = "${BRIGHT_WHITE}"

selection_fg = "${ANSI_WHITE}"
selection_bg = "${EXTRA_GRAY1}"

scrollbar_thumb = "${ANSI_WHITE}"
split = "${SELECTION}"

# Before 16 colors, there were 8 colors: black, red, green, yellow, blue,
# magenta, cyan, and white. The other 8 were added as their bright variants.
ansi = [
    "${ANSI_BLACK}",
    "${ANSI_RED}",
    "${ANSI_GREEN}",
    "${ANSI_YELLOW}",
    "${ANSI_BLUE}",
    "${ANSI_MAGENTA}",
    "${ANSI_CYAN}",
    "${ANSI_WHITE}",
]
brights = [
    "${BRIGHT_BLACK}",
    "${BRIGHT_RED}",
    "${BRIGHT_GREEN}",
    "${BRIGHT_YELLOW}",
    "${BRIGHT_BLUE}",
    "${BRIGHT_MAGENTA}",
    "${BRIGHT_CYAN}",
    "${BRIGHT_WHITE}",
]

copy_mode_active_highlight_bg = { Color = "${ANSI_GREEN}" }
copy_mode_active_highlight_fg = { Color = "${EXTRA_BG1}" }
copy_mode_inactive_highlight_bg = { Color = "${ANSI_GREEN}" }
copy_mode_inactive_highlight_fg = { Color = "${ANSI_BLACK}" }

quick_select_label_bg = { Color = "${BRIGHT_GREEN}" }
quick_select_label_fg = { Color = "${EXTRA_BG1}" }
quick_select_match_bg = { Color = "${ANSI_CYAN}" }
quick_select_match_fg = { Color = "${ANSI_BLACK}" }

# Keep the retro tab bar seamless with the terminal background.
[colors.tab_bar]
background = "${BACKGROUND}"
inactive_tab_edge = "${BACKGROUND}"

[colors.tab_bar.active_tab]
bg_color = "${BACKGROUND}"
fg_color = "${ANSI_WHITE}"

[colors.tab_bar.inactive_tab]
bg_color = "${BACKGROUND}"
fg_color = "${ANSI_WHITE}"
EOD

done
