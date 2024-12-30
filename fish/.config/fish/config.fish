function alias
    if status is-interactive
        alias k=kubectl
        alias imgcat='wezterm imgcat'
        alias ghs='gh copilot suggest -t shell'
        alias ghe='gh copilot explain -t shell'
    end
end

function __fzf_history_search
    commandline (history | fzf)
    commandline -f execute
end

function fish_user_key_bindings
    bind -k nul forward-word
    bind \cr __fzf_history_search
    # bind \cl __fish_clear_buffer
end

# Show only basename of current directory in tabbar
function fish_title
    set -q argv[1]; or set argv ""
    echo (basename (prompt_pwd)) $argv
end
