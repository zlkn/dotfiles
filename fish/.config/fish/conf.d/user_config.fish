if not status is-interactive
    exit
end

set -g -x USE_GKE_GCLOUD_AUTH_PLUGIN True
set -gx ANTHROPIC_API_KEY (python3 -c "import json; print(json.load(open('$HOME/.claude.json'))['primaryApiKey'])" 2>/dev/null)
set -gx HELIX_RUNTIME "$HOME/dotfiles/helix/.config/helix/runtime"

if command -q pass
    set -gx ANTHROPIC_API_KEY (pass show tokens/ANTHROPIC_API_KEY)
else
    echo "WARNING: 'pass' is not installed. Secret tokens for session not configured"
end


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

