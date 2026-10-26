import math
from itertools import combinations

from palettes import Palette

from . import apca
from .wcag import paint

type Vector = tuple[float, float, float]
type Matrix = tuple[Vector, Vector, Vector]

ACCENTS = ["normal"] + [
    f"bright_{c}" for c in ("red", "green", "yellow", "blue", "magenta", "cyan")
]

CVD: dict[str, Matrix] = {
    "protan": (
        (0.152286, 1.052583, -0.204868),
        (0.114503, 0.786281, 0.099216),
        (-0.003882, -0.048116, 1.051998),
    ),
    "deutan": (
        (0.367322, 0.860646, -0.227968),
        (0.280085, 0.672501, 0.047413),
        (-0.011820, 0.042940, 0.968881),
    ),
}


def linear(color: str) -> Vector:
    def channel(hex_value: str) -> float:
        c = int(hex_value, 16) / 255
        return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4

    r, g, b = (channel(color[i : i + 2]) for i in (1, 3, 5))
    return r, g, b


def multiply(m: Matrix, v: Vector) -> Vector:
    x, y, z = (sum(a * b for a, b in zip(row, v)) for row in m)
    return x, y, z


def simulate(rgb: Vector, kind: str) -> Vector:
    r, g, b = (min(max(c, 0.0), 1.0) for c in multiply(CVD[kind], rgb))
    return r, g, b


def lab(rgb: Vector) -> Vector:
    x, y, z = multiply(
        (
            (0.4124564, 0.3575761, 0.1804375),
            (0.2126729, 0.7151522, 0.0721750),
            (0.0193339, 0.1191920, 0.9503041),
        ),
        rgb,
    )

    def f(t: float) -> float:
        return t ** (1 / 3) if t > 216 / 24389 else (24389 / 27 * t + 16) / 116

    fx, fy, fz = f(x / 0.95047), f(y), f(z / 1.08883)
    return 116 * fy - 16, 500 * (fx - fy), 200 * (fy - fz)


def ciede2000(lab1: Vector, lab2: Vector) -> float:
    l1, a1, b1 = lab1
    l2, a2, b2 = lab2
    c_mean = (math.hypot(a1, b1) + math.hypot(a2, b2)) / 2
    g = 0.5 * (1 - math.sqrt(c_mean**7 / (c_mean**7 + 25**7)))
    a1, a2 = (1 + g) * a1, (1 + g) * a2
    c1, c2 = math.hypot(a1, b1), math.hypot(a2, b2)
    h1 = math.degrees(math.atan2(b1, a1)) % 360
    h2 = math.degrees(math.atan2(b2, a2)) % 360

    if c1 * c2 == 0:
        dh, h_mean = 0.0, h1 + h2
    else:
        dh = h2 - h1
        if dh > 180:
            dh -= 360
        elif dh < -180:
            dh += 360
        h_mean = (h1 + h2) / 2
        if abs(h1 - h2) > 180:
            h_mean += 180 if h_mean < 180 else -180

    dl, dc = l2 - l1, c2 - c1
    dh_big = 2 * math.sqrt(c1 * c2) * math.sin(math.radians(dh / 2))
    l_mean, c_mean = (l1 + l2) / 2, (c1 + c2) / 2

    t = (
        1
        - 0.17 * math.cos(math.radians(h_mean - 30))
        + 0.24 * math.cos(math.radians(2 * h_mean))
        + 0.32 * math.cos(math.radians(3 * h_mean + 6))
        - 0.20 * math.cos(math.radians(4 * h_mean - 63))
    )
    sl = 1 + 0.015 * (l_mean - 50) ** 2 / math.sqrt(20 + (l_mean - 50) ** 2)
    sc = 1 + 0.045 * c_mean
    sh = 1 + 0.015 * c_mean * t
    rt = (
        -2
        * math.sqrt(c_mean**7 / (c_mean**7 + 25**7))
        * math.sin(math.radians(60 * math.exp(-(((h_mean - 275) / 25) ** 2))))
    )
    return math.sqrt(
        (dl / sl) ** 2
        + (dc / sc) ** 2
        + (dh_big / sh) ** 2
        + rt * (dc / sc) * (dh_big / sh)
    )


def distance(c1: str, c2: str, kind: str | None = None) -> float:
    rgb1, rgb2 = linear(c1), linear(c2)
    if kind:
        rgb1, rgb2 = simulate(rgb1, kind), simulate(rgb2, kind)
    return ciede2000(lab(rgb1), lab(rgb2))


def level(de: float) -> str:
    if de >= 15:
        return "OK"
    if de >= 10:
        return "WEAK"
    return "FAIL"


def report(variant: str, palette: Palette) -> None:
    bg = palette["background"]
    print(f"{variant} (background {bg})")
    print(f"  {'pair':<21} {'ΔE':>5}  {'protan':>6}  {'deutan':>6}")

    def label(name: str) -> str:
        mark = "*" if abs(apca.contrast(palette[name], bg)) < 60 else " "
        return paint(f" {name.removeprefix('bright_'):<8}{mark}", palette[name], bg)

    rows = sorted(
        (distance(palette[a], palette[b]), a, b) for a, b in combinations(ACCENTS, 2)
    )
    for de, a, b in rows:
        cvd = [
            distance(palette[a], palette[b], kind) for kind in ("protan", "deutan")
        ]
        worst = min(de, *cvd)
        print(
            f"  {label(a)} {label(b)}"
            f" {de:5.1f}  {cvd[0]:6.1f}  {cvd[1]:6.1f}  {level(worst)}"
        )
    print("  * |Lc| < 60: ΔE inflated by lightness, check APCA first")
    print()
