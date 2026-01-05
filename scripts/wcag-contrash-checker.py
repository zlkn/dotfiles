import sys

# WCAG 2.1 Contrast Ratio requirements:
# AA: 4.5:1 for normal text, 3:1 for large text.
# AAA: 7:1 for normal text, 4.5:1 for large text.
MIN_AA_NORMAL = 4.5
MIN_AA_LARGE = 3.0
MIN_AAA_NORMAL = 7.0
MIN_AAA_LARGE = 4.5


def hex_to_normalized_rgb(hex_color: str) -> tuple[float, float, float]:
    """
    Converts a hex color string (e.g., '#424242') to a tuple of
    normalized RGB values (0.0 to 1.0).
    """
    hex_color = hex_color.lstrip("#")
    if len(hex_color) != 6:
        raise ValueError(
            f"Invalid hex color format: {hex_color}. Must be 6 characters."
        )

    r = int(hex_color[0:2], 16) / 255.0
    g = int(hex_color[2:4], 16) / 255.0
    b = int(hex_color[4:6], 16) / 255.0

    return r, g, b


def get_luminance(r_srgb: float, g_srgb: float, b_srgb: float) -> float:
    """
    Calculates the relative luminance (L) of an sRGB color using the WCAG
    standard formula (which first converts sRGB to linear RGB).

    L = 0.2126 * R + 0.7152 * G + 0.0722 * B
    """

    def linearize_channel(channel: float) -> float:
        """Converts an sRGB color channel (0.0-1.0) to linear RGB."""
        if channel <= 0.03928:
            return channel / 12.92
        else:
            # (R_srgb + 0.055 / 1.055) ^ 2.4
            return ((channel + 0.055) / 1.055) ** 2.4

    R = linearize_channel(r_srgb)
    G = linearize_channel(g_srgb)
    B = linearize_channel(b_srgb)

    # Relative luminance calculation
    L = (0.2126 * R) + (0.7152 * G) + (0.0722 * B)
    return L


def get_contrast_ratio(L1: float, L2: float) -> float:
    """
    Calculates the contrast ratio between two luminances (L1 and L2).
    L1 must be the lighter luminance, L2 the darker.

    Contrast Ratio = (L_lighter + 0.05) / (L_darker + 0.05)
    """
    lighter = max(L1, L2)
    darker = min(L1, L2)

    return (lighter + 0.05) / (darker + 0.05)


def check_wcag_level(ratio: float) -> str:
    """
    Determines the WCAG 2.1 conformance level based on the contrast ratio.
    """
    levels = []

    # Normal Text (less than 18pt or 14pt bold)
    if ratio >= MIN_AAA_NORMAL:
        levels.append(f"AAA (Normal Text: {MIN_AAA_NORMAL}:1)")
    elif ratio >= MIN_AA_NORMAL:
        levels.append(f"AA (Normal Text: {MIN_AA_NORMAL}:1)")

    # Large Text (18pt or larger, or 14pt bold or larger)
    if ratio >= MIN_AAA_LARGE:
        levels.append(f"AAA (Large Text: {MIN_AAA_LARGE}:1)")
    elif ratio >= MIN_AA_LARGE:
        levels.append(f"AA (Large Text: {MIN_AA_LARGE}:1)")

    if not levels:
        return "FAIL (Does not meet AA requirements for any text size)"

    # Sort for best presentation: AAA first, then AA
    levels.sort(key=lambda x: x.split(" ")[0], reverse=True)
    return " | ".join(levels)


def main():
    """Main function to parse arguments and calculate contrast."""
    if len(sys.argv) < 3:
        print("Error: Two hexadecimal colors are required.")
        print("\nUsage: python contrast_checker.py <foreground_hex> <background_hex>")
        print("Example: python contrast_checker.py #424242 #d3e3fd")
        sys.exit(1)

    fg_hex = sys.argv[1].strip()
    bg_hex = sys.argv[2].strip()

    try:
        # 1. Convert Hex to Normalized sRGB (0-1)
        r_fg, g_fg, b_fg = hex_to_normalized_rgb(fg_hex)
        r_bg, g_bg, b_bg = hex_to_normalized_rgb(bg_hex)

        # 2. Calculate Luminance (L)
        L_fg = get_luminance(r_fg, g_fg, b_fg)
        L_bg = get_luminance(r_bg, g_bg, b_bg)

        # 3. Calculate Contrast Ratio
        ratio = get_contrast_ratio(L_fg, L_bg)

        # 4. Determine WCAG Conformance
        wcag_level = check_wcag_level(ratio)

        # Output Results
        print("\n--- Contrast Check Results (WCAG 2.1) ---")
        print(f"Foreground Color (FG): {fg_hex}")
        print(f"Background Color (BG): {bg_hex}")
        print(f"FG Luminance (L_fg): {L_fg:.4f}")
        print(f"BG Luminance (L_bg): {L_bg:.4f}")
        print("-" * 37)
        print(f"Contrast Ratio: {ratio:.2f}:1")
        print(f"WCAG Conformance: {wcag_level}")
        print("-" * 37)

    except ValueError as e:
        print(f"\nError: {e}")
        print("Please ensure colors are in '#RRGGBB' format (e.g., #424242).")
        sys.exit(1)
    except Exception as e:
        print(f"\nAn unexpected error occurred: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
