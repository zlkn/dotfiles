# Single source of truth for every generated theme file.
# aqua ships two variants: aqua_day (light) and aqua_night (dark).

AQUA_DAY = {
    "normal": "#424242",
    "cursor": "#20bbfc",
    "background": "#ebebed",
    "selection": "#dfdfe1",

    "ansi_black": "#d1d1d1",
    "ansi_red": "#b31367",
    "ansi_green": "#1e763c",
    "ansi_yellow": "#825400",
    "ansi_blue": "#15609f",
    "ansi_magenta": "#75228e",
    "ansi_cyan": "#007474",
    "ansi_white": "#424242",

    "bright_black": "#686e75",
    "bright_red": "#b31367",
    "bright_green": "#1e763c",
    "bright_yellow": "#825400",
    "bright_blue": "#015493",
    "bright_magenta": "#75228e",
    "bright_cyan": "#007474",
    "bright_white": "#002338",

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
    "normal": "#dde2e4",
    "cursor": "#20bbfc",
    "background": "#3d3b41",
    "selection": "#404446",

    "ansi_black": "#494d4f",
    "ansi_red": "#ff97be",
    "ansi_green": "#1e763c",
    "ansi_yellow": "#dbaf75",
    "ansi_blue": "#7fbbf9",
    "ansi_magenta": "#8a3aa4",
    "ansi_cyan": "#7cc2c2",
    "ansi_white": "#dde2e4",

    "bright_black": "#adb5bf",
    "bright_red": "#ff97be",
    "bright_green": "#7fc78e",
    "bright_yellow": "#dbaf75",
    "bright_blue": "#7fbbf9",
    "bright_magenta": "#8a3aa4",
    "bright_cyan": "#7cc2c2",
    "bright_white": "#bdf2ff",

    "extra_bg1": "#35383b",
    "extra_bg2": "#3b3f41",
    "extra_pencil_gray": "#6f7275",
    "extra_gray0": "#404446",
    "extra_gray1": "#494d4f",
    "extra_gray2": "#6b6f71",
    "extra_gray3": "#adb5bf",
    "extra_gray4": "#3c4748",
    "extra_gray5": "#5c5f62",
    "extra_white": "#7d8e9f",
}

VARIANTS = {
    "aqua_day": AQUA_DAY,
    "aqua_night": AQUA_NIGHT,
}
