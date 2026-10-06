import string
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]


def render(template, variant, palette):
    return string.Template(template).substitute(palette, variant=variant)


def write(dst, template, variant, palette):
    path = REPO_ROOT / dst
    print(f"Populate {dst}")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(render(template, variant, palette))
