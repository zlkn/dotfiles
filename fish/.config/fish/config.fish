if status is-interactive
    alias k=kubectl
    alias imgcat='wezterm imgcat'
    alias ghs='gh copilot suggest -t shell'
    alias ghe='gh copilot explain -t shell'
end

function __fzf_history_search
    commandline (history | fzf)
    commandline -f execute
end

function fish_user_key_bindings
    bind -k nul forward-word
    # bind \cr __fzf_history_search
end
