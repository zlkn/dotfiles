from palettes import Palette

type Role = str

SURFACES = {
    "background",
    "selection",
    "ansi_black",
    "extra_bg1",
    "extra_bg2",
    "extra_gray0",
    "extra_gray1",
    "extra_gray4",
    "extra_gray5",
}
NON_TEXT = {"extra_pencil_gray", "extra_gray2"}


def rows(palette: Palette) -> list[tuple[str, str, Role]]:
    result: list[tuple[str, str, Role]] = []
    for name, color in palette.items():
        if name in SURFACES:
            continue
        base = name
        if name.startswith("ansi_"):
            twin = "bright_" + name.removeprefix("ansi_")
            if palette.get(twin) == color:
                base = name.removeprefix("ansi_")
        elif name.startswith("bright_"):
            if palette.get("ansi_" + name.removeprefix("bright_")) == color:
                continue
        result.append((base, color, "non-text" if name in NON_TEXT else "text"))
    return result


def surfaces(palette: Palette) -> str:
    return ", ".join(name for name in palette if name in SURFACES - {"background"})
