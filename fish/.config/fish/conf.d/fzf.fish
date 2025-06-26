#  In this package the executable and its manpage have been renamed from ‘bat’ to
# ‘batcat’ because of a file name clash with another Debian package.

# set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1 --bind='F2:toggle-preview' \
set -gx FZF_DEFAULT_OPTS "--multi \
--height=60% --layout=reverse --info=inline --bind='F2:toggle-preview' \
--color=bg+:#e1e1e1,bg:-1,fg:#313131,fg+:#1f1f1f,hl:#871094,hl+:#871094 \
--color=gutter:-1,header:#10a778,marker:#cc6666,prompt:#81a2be,spinner:#f0c674"
