from . import gty, nvim, wezterm

APPS = [gty, nvim, wezterm]


def generate(variant, palette):
    for app in APPS:
        app.generate(variant, palette)
