#  In this package the executable and its manpage have been renamed from ‘bat’ to
# ‘batcat’ because of a file name clash with another Debian package.

set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1 --bind='F2:toggle-preview' \
--color=bg+:#f8f8f8,bg:#f8f8f8,spinner:#f0c674,hl:#c30771 \
--color=fg:#2e3436,header:#10a778,info:#20a5ba,pointer:#20a5ba \
--color=marker:#cc6666,fg+:#20a5ba,prompt:#81a2be,hl+:#c30771"
