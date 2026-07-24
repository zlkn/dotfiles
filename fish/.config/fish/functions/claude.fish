if not status is-interactive
    exit
end

function claude
    if command -q pass
        set -x ANTHROPIC_API_KEY (pass tokens/ANTHROPIC_API_KEY)
        set -x YOUTRACK_TOKEN (pass tokens/youtrack)
        set -x GITLAB_TOKEN (pass tokens/glab-cli)
    else
        echo "pass is not installed, cannot get ANTHROPIC_API_KEY"
        return 1
    end
    command claude $argv
end
