def get_luminance(hex_color):
    """Вычисляет относительную яркость цвета."""
    hex_color = hex_color.lstrip("#")
    rgb = [int(hex_color[i : i + 2], 16) / 255.0 for i in (0, 2, 4)]

    # Формула преобразования в линейный RGB
    luc = []
    for c in rgb:
        if c <= 0.03928:
            luc.append(c / 12.92)
        else:
            luc.append(((c + 0.055) / 1.055) ** 2.4)

    return 0.2126 * luc[0] + 0.7152 * luc[1] + 0.0722 * luc[2]


def get_contrast_ratio(color1, color2):
    """Вычисляет коэффициент контрастности (от 1 до 21)."""
    lum1 = get_luminance(color1)
    lum2 = get_luminance(color2)

    # Формула: (L1 + 0.05) / (L2 + 0.05)
    brightest = max(lum1, lum2)
    darkest = min(lum1, lum2)
    return (brightest + 0.05) / (darkest + 0.05)


# Данные вашей темы
bg_color = "#ededed"
ansi_colors = {
    "black": "#f0edec",
    "red": "#c30771",
    "green": "#218242",
    "yellow": "#b57414",
    "blue": "#015493",
    "magenta": "#75228e",
    "cyan": "#007474",
    "white": "#2C363C",
}

print(f"{'Цвет':<10} | {'Contrast':<10} | {'WCAG AA (4.5:1)':<15}")
print("-" * 40)

for name, hex_val in ansi_colors.items():
    ratio = get_contrast_ratio(bg_color, hex_val)
    status = "✅ PASS" if ratio >= 4.5 else "❌ FAIL"
    print(f"{name:<10} | {ratio:>8.2f}:1 | {status}")
