import math
from statistics import median

from palettes import Palette

from .deltae import ACCENTS, linear
from .wcag import paint

type Vector = tuple[float, float, float]

L_TOLERANCE = 0.03
C_TOLERANCE = 0.25


def oklch(color: str) -> Vector:
    r, g, b = linear(color)
    l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
    m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
    s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b
    l, m, s = (math.cbrt(x) for x in (l, m, s))
    lightness = 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s
    a = 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s
    b = 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
    return lightness, math.hypot(a, b), math.degrees(math.atan2(b, a)) % 360


def report(variant: str, palette: Palette) -> None:
    bg = palette["background"]
    names = [name for name in ACCENTS if name != "normal"]
    values = {name: oklch(palette[name]) for name in names}
    l_median = median(v[0] for v in values.values())
    c_median = median(v[1] for v in values.values())

    print(f"{variant} (background {bg}, median L {l_median:.3f}, C {c_median:.3f})")
    print(f"  {'color':<18} {'L':>5}  {'C':>5}  {'H':>5}  {'ΔL':>6}  {'ΔC':>5}")
    for name in names:
        lightness, chroma, hue = values[name]
        dl = lightness - l_median
        dc = chroma / c_median - 1
        flags = [
            label
            for label, off in (("L", abs(dl) > L_TOLERANCE), ("C", abs(dc) > C_TOLERANCE))
            if off
        ]
        sample = paint(f" {name.removeprefix('bright_'):<8} {palette[name]} ", palette[name], bg)
        print(
            f"  {sample} {lightness:5.3f}  {chroma:5.3f}  {hue:5.1f}"
            f"  {dl:+6.3f}  {dc:+5.0%}  {'OFF ' + ','.join(flags) if flags else 'OK'}"
        )
    print(f"  OFF: |ΔL| > {L_TOLERANCE} or |ΔC| > {C_TOLERANCE:.0%} of median")
    print()
