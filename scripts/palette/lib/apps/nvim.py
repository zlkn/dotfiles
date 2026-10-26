from palettes import Palette
from render import write

NVIM_LUA_DIR = "vim/.config/nvim/lua"

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


def generate(variant: str, palette: Palette) -> None:
    write(f"{NVIM_LUA_DIR}/palette_{variant}.lua", PALETTE_LUA, variant, palette)
