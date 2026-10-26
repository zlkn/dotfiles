from palettes import Palette

from . import gty, nvim, wezterm

APPS = [gty, nvim, wezterm]


def generate(variant: str, palette: Palette) -> None:
    for app in APPS:
        app.generate(variant, palette)
