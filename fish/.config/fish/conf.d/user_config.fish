if not status is-interactive
    exit
end

set -g -x USE_GKE_GCLOUD_AUTH_PLUGIN True

function __fzf_history_search
    commandline (history | fzf)
    commandline --function --replace
end

function __fish_clear_buffer
    for line in (seq 2 (tput lines))
        printf "$line\n"
    end
    printf "\033[H\033[2J"
    commandline -f repaint
end

function fish_user_key_bindings
    # bind -k nul forward-word
    # bind \cr __fzf_history_search
    bind \cl __fish_clear_buffer
    bind \cq __fish_clear_buffer
end

__auto_source_venv

