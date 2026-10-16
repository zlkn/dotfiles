from palettes import Palette


def luminance(color: str) -> float:
    def channel(hex_value: str) -> float:
        c = int(hex_value, 16) / 255
        return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4

    r, g, b = (channel(color[i : i + 2]) for i in (1, 3, 5))
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def contrast(fg: str, bg: str) -> float:
    lighter, darker = sorted((luminance(fg), luminance(bg)), reverse=True)
    return (lighter + 0.05) / (darker + 0.05)


def level(ratio: float) -> str:
    if ratio >= 7:
        return "AAA"
    if ratio >= 4.5:
        return "AA"
    if ratio >= 3:
        return "AA Large"
    return "FAIL"


def paint(text: str, fg: str, bg: str) -> str:
    def rgb(color: str) -> str:
        return ";".join(str(int(color[i : i + 2], 16)) for i in (1, 3, 5))

    return f"\033[38;2;{rgb(fg)};48;2;{rgb(bg)}m{text}\033[0m"


def report(variant: str, palette: Palette) -> None:
    bg = palette["background"]
    print(f"{variant} (background {bg})")
    for name, color in palette.items():
        if name == "background":
            continue
        ratio = contrast(color, bg)
        sample = paint(f" {name:<20} {color} ", color, bg)
        print(f"  {sample}  {ratio:5.2f}:1  {level(ratio)}")
    print()
