import os

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb


PROCESS_ICONS = {
    'nvim': '',
    'vim': '',
    'vi': '',
    'nano': '',
    'hx': '',
    'emacs': '',
    'git': '',
    'lazygit': '',
    'gh': '',
    'ssh': '',
    'docker': '',
    'kubectl': '󱃾',
    'node': '',
    'npm': '',
    'pnpm': '',
    'yarn': '',
    'deno': '',
    'bun': '',
    'python': '',
    'python3': '',
    'ipython': '',
    'cargo': '',
    'rustc': '',
    'go': '',
    'make': '',
    'htop': '',
    'btop': '',
    'top': '',
    'tmux': '',
    'fish': '',
    'bash': '',
    'zsh': '',
    'sh': '',
}
DEFAULT_ICON = ''


def process_name_for_tab(tab_id: int) -> str:
    boss = get_boss()
    tab = boss.tab_for_id(tab_id)
    if not tab:
        return ''
    window = tab.active_window
    if not window:
        return ''
    try:
        procs = window.child.foreground_processes
    except Exception:
        return ''
    if not procs:
        return ''
    cmdline = procs[-1].get('cmdline') or []
    if not cmdline:
        return ''
    exe = os.path.basename(cmdline[0])
    if exe.startswith('-'):
        exe = exe[1:]
    return exe


def icon_for_tab(tab_id: int) -> str:
    name = process_name_for_tab(tab_id)
    return PROCESS_ICONS.get(name, DEFAULT_ICON)


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

    icon = icon_for_tab(tab.tab_id)
    title = tab.title or ''
    prefix = f'{icon} ' if icon else ''

    text = f'{prefix}{title}'
    text_w = wcswidth(text)
    if text_w > cell_width:
        while title and wcswidth(f'{prefix}{title}…') > cell_width:
            title = title[:-1]
        text = f'{prefix}{title}…' if title else prefix.rstrip()
        text_w = wcswidth(text)

    pad_total = max(0, cell_width - text_w)
    left = pad_total // 2
    right = pad_total - left

    multi = n > 1

    screen.cursor.fg = as_rgb(int(draw_data.inactive_fg))
    screen.cursor.bg = as_rgb(int(draw_data.inactive_bg))

    if tab.is_active:
        screen.cursor.bold = True
        screen.cursor.decoration = 1 if multi else 0
        screen.cursor.decoration_fg = as_rgb(0x5f87ff)
    else:
        screen.cursor.bold = False
        screen.cursor.decoration = 1 if multi else 0
        screen.cursor.decoration_fg = as_rgb(0xa0a0a0)

    screen.draw(' ' * left + text + ' ' * right)

    screen.cursor.bold = False
    screen.cursor.decoration = 0
    screen.cursor.decoration_fg = 0
    screen.cursor.fg = 0
    screen.cursor.bg = 0
    return screen.cursor.x
