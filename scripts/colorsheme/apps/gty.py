from render import write

GTY_THEMES_DIR = "gty/.config/gty/themes"

# language=toml
GTY_TOML = """\
# !!! Generated do not edit manually !!!
background = "${background}"
foreground = "${ansi_white}"
selection = "${extra_gray1}"
cursor = "${cursor}"

ansi = [
  "${ansi_black}", "${ansi_red}", "${ansi_green}", "${ansi_yellow}",
  "${ansi_blue}", "${ansi_magenta}", "${ansi_cyan}", "${ansi_white}",
]

bright = [
  "${bright_black}", "${bright_red}", "${bright_green}", "${bright_yellow}",
  "${bright_blue}", "${bright_magenta}", "${bright_cyan}", "${bright_white}",
]
"""


def generate(variant, palette):
    write(f"{GTY_THEMES_DIR}/{variant}.toml", GTY_TOML, variant, palette)
