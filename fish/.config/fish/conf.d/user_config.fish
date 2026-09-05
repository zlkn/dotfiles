if not status is-interactive
    exit
end

set -g -x USE_GKE_GCLOUD_AUTH_PLUGIN True
# set -g -x GOPATH /usr/local/go/bin
set -g -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -g -x CMD_COUNT 0

function __fish_clear_buffer
    for line in (seq 2 (tput lines))
        printf "$line\n"
    end
    printf "\033[H\033[2J"
    commandline -f repaint
end

function fish_user_key_bindings
    bind \cl __fish_clear_buffer
    bind \cq __fish_clear_buffer
end

__auto_source_venv

