from palettes import Palette

from .roles import Role, rows, surfaces
from .wcag import paint

REQUIRED: dict[Role, float] = {"text": 60, "non-text": 15}


def luminance(color: str) -> float:
    r, g, b = ((int(color[i : i + 2], 16) / 255) ** 2.4 for i in (1, 3, 5))
    y = 0.2126729 * r + 0.7151522 * g + 0.0721750 * b
    return y if y > 0.022 else y + (0.022 - y) ** 1.414


def contrast(fg: str, bg: str) -> float:
    y_fg, y_bg = luminance(fg), luminance(bg)
    if abs(y_bg - y_fg) < 0.0005:
        return 0.0
    if y_bg > y_fg:
        sapc = (y_bg**0.56 - y_fg**0.57) * 1.14
        return 0.0 if sapc < 0.1 else (sapc - 0.027) * 100
    sapc = (y_bg**0.65 - y_fg**0.62) * 1.14
    return 0.0 if sapc > -0.1 else (sapc + 0.027) * 100


def level(lc: float) -> str:
    lc = abs(lc)
    if lc >= 90:
        return "Body+"
    if lc >= 75:
        return "Body"
    if lc >= 60:
        return "Content"
    if lc >= 45:
        return "Large"
    if lc >= 30:
        return "Spot"
    if lc >= 15:
        return "Non-text"
    return "FAIL"


def report(variant: str, palette: Palette) -> None:
    bg = palette["background"]
    results = [(name, color, role, contrast(color, bg)) for name, color, role in rows(palette)]
    failed = sum(abs(lc) < REQUIRED[role] for *_, role, lc in results)
    print(f"{variant} (background {bg}, failed {failed}/{len(results)})")
    print(f"  {'color':<27} {'Lc':>6}  {'level':<8}  {'need':>4}  result")
    for name, color, role, lc in results:
        sample = paint(f" {name:<17} {color} ", color, bg)
        need = REQUIRED[role]
        print(
            f"  {sample} {lc:6.1f}  {level(lc):<8}  {need:4.0f}"
            f"  {'OK' if abs(lc) >= need else 'FAIL'}"
        )
    print(f"  need: |Lc| text {REQUIRED['text']}, non-text {REQUIRED['non-text']}")
    print(f"  skipped surfaces: {surfaces(palette)}")
    print()
