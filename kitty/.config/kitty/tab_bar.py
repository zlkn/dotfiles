import os

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb


# Palette (ported from wezterm palette.lua)
C_BLACK = 0xD1D1D1
C_RED = 0xB81A6B
C_GREEN = 0x1E763C
C_YELLOW = 0x8D5B00
C_BLUE = 0x015493
C_MAGENTA = 0x75228E
C_CYAN = 0x007474
C_WHITE = 0x424242
C_BRIGHT_BLACK = 0x57606A

ICON_DEFAULT = ("\U000f0640", C_WHITE)  # md_collage

# (symbol, fg_color) — keyed by exec basename
PROCESS_ICONS: dict[str, tuple[str, int]] = {
    # shells
    "sh":   ("\U000f018d", C_BLACK),        # md_console_line
    "bash": ("\U000f018d", C_BLACK),
    "zsh":  ("\U000f018d", C_BLACK),
    "fish": ("\U000f018d", C_WHITE),
    # editors
    "nvim":  ("\uf36f", C_GREEN),           # linux_neovim
    "vim":   ("\uf36f", C_WHITE),
    "vi":    ("\uf36f", C_WHITE),
    "nano":  ("\uf36f", C_WHITE),
    "hx":    ("\uf36f", C_WHITE),
    "emacs": ("\uf36f", C_WHITE),
    # vcs / github
    "git":     ("\uf113", C_MAGENTA),       # fa_github_alt
    "lazygit": ("\uf113", C_MAGENTA),
    "gh":      ("\uf113", C_MAGENTA),
    # remote
    "ssh":  ("\U000f0163", C_CYAN),         # md_cloud
    "sftp": ("\U000f0163", C_CYAN),
    # k8s
    "kubectl": ("\U000f10fe", C_BLUE),      # md_kubernetes
    "k9s":     ("\U000f10fe", C_BLUE),
    # sysmon
    "btm":  ("\U000f0336", C_BRIGHT_BLACK), # md_gauge
    "top":  ("\U000f0336", C_BRIGHT_BLACK),
    "htop": ("\U000f0336", C_BRIGHT_BLACK),
    "btop": ("\U000f0336", C_BRIGHT_BLACK),
    "ntop": ("\U000f0336", C_BRIGHT_BLACK),
    # pagers / search
    "bat":  ("\U000f0349", C_WHITE),        # md_magnify
    "less": ("\U000f0349", C_WHITE),
    "moar": ("\U000f0349", C_WHITE),
    "fzf":  ("\U000f0349", C_WHITE),
    "peco": ("\U000f0349", C_WHITE),
    "man":  ("\U000f0349", C_WHITE),
    # net
    "aria2c": ("\U000f0241", C_WHITE),      # md_flash
    "curl":   ("\U000f0241", C_WHITE),
    "wget":   ("\U000f0241", C_WHITE),
    "yt-dlp": ("\U000f0241", C_WHITE),
    "rsync":  ("\U000f0241", C_WHITE),
    # python
    "python":  ("\U000f0320", C_YELLOW),    # md_language_python
    "python3": ("\U000f0320", C_YELLOW),
    "ipython": ("\U000f0320", C_YELLOW),
    # cloud / infra
    "terraform": ("\U000f1062", C_MAGENTA), # md_terraform
    "gcloud":    ("\U000f11f6", C_CYAN),    # md_google_cloud
    "docker":    ("\ue7b0", C_BLUE),
    # build
    "make": ("\ueb9c", C_GREEN),            # cod_run_all
}

BAR_BG = 0xF2F2F2           # palette.extra.bg1
ACTIVE_BG = 0xD1D1D1        # palette.ansi.black
ACTIVE_PILL_RATIO = 0.8     # pill fills 80% of the tab cell


def process_name_for_tab(tab_id: int) -> str:
    boss = get_boss()
    tab = boss.tab_for_id(tab_id)
    if not tab:
        return ""
    window = tab.active_window
    if not window:
        return ""
    try:
        procs = window.child.foreground_processes
    except Exception:
        return ""
    if not procs:
        return ""
    cmdline = procs[-1].get("cmdline") or []
    if not cmdline:
        return ""
    exe = os.path.basename(cmdline[0])
    if exe.startswith("-"):
        exe = exe[1:]
    return exe


def icon_for_tab(tab_id: int) -> tuple[str, int]:
    name = process_name_for_tab(tab_id)
    return PROCESS_ICONS.get(name, ICON_DEFAULT)


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    tm = get_boss().active_tab_manager
    n = max(1, len(tm.tabs)) if tm else 1
    cell_width = screen.columns // n
    if is_last:
        cell_width += screen.columns - cell_width * n

    icon_sym, icon_color = icon_for_tab(tab.tab_id)
    title = tab.title or ""
    prefix = f"{icon_sym} " if icon_sym else ""

    multi = n > 1
    edge_w = 2 if multi else 0
    content_max = max(0, cell_width - edge_w)
    suffix = ""
    text_w = wcswidth(f"{prefix}{title}")
    if text_w > content_max:
        while title and wcswidth(f"{prefix}{title}…") > content_max:
            title = title[:-1]
        if title:
            suffix = "…"
        else:
            prefix = prefix.rstrip()
    text_w = wcswidth(f"{prefix}{title}{suffix}")

    if multi and tab.is_active:
        pill_w = min(max(int(cell_width * ACTIVE_PILL_RATIO), text_w + edge_w), cell_width)
        pill_inner = pill_w - edge_w - text_w
        left_in = pill_inner // 2
        right_in = pill_inner - left_in
        outer = cell_width - pill_w
        left_out = outer // 2
        right_out = outer - left_out
    else:
        pad = max(0, cell_width - text_w - edge_w)
        left_out = pad // 2
        right_out = pad - left_out
        left_in = 0
        right_in = 0

    fg = as_rgb(int(draw_data.inactive_fg))
    bar_bg = as_rgb(BAR_BG)
    tab_bg = as_rgb(ACTIVE_BG if (multi and tab.is_active) else BAR_BG)
    icon_fg = as_rgb(icon_color)

    screen.cursor.bold = tab.is_active
    screen.cursor.decoration = 0

    # left outer padding (bar bg)
    screen.cursor.fg = fg
    screen.cursor.bg = bar_bg
    screen.draw(" " * left_out)

    if multi:
        screen.cursor.fg = tab_bg
        screen.draw("\ue0b6")

    # pill body
    screen.cursor.bg = tab_bg
    screen.cursor.fg = fg
    screen.draw(" " * left_in)
    if prefix:
        screen.cursor.fg = icon_fg
        screen.draw(prefix)
    screen.cursor.fg = fg
    screen.draw(f"{title}{suffix}")
    screen.draw(" " * right_in)

    if multi:
        screen.cursor.fg = tab_bg
        screen.cursor.bg = bar_bg
        screen.draw("\ue0b4")

    screen.cursor.bg = bar_bg
    screen.draw(" " * right_out)

    screen.cursor.bold = False
    screen.cursor.fg = 0
    screen.cursor.bg = 0
    return screen.cursor.x
