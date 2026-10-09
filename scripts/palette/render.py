import string
from pathlib import Path

from palettes import Palette

REPO_ROOT = Path(__file__).resolve().parents[2]


def render(template: str, variant: str, palette: Palette) -> str:
    return string.Template(template).substitute(palette, variant=variant)


def write(dst: str, template: str, variant: str, palette: Palette) -> None:
    path = REPO_ROOT / dst
    print(f"Populate {dst}")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(render(template, variant, palette))
