# Fork of https://github.com/oh-my-fish/theme-nai
# name: nai-plus
# Display the following bits on the left:
# * Current directory name
# * Git branch and dirty state (if inside a git repo)

function _git_branch_name
    command git symbolic-ref --short HEAD 2> /dev/null
end

function _git_ahead_behind
    # Returns "behind\tahead" in one git call
    command git rev-list --left-right --count @{u}...HEAD 2> /dev/null
end

function _git_info
    set -l git_info ""

    set -l yellow (set_color yellow)
    set -l green (set_color brgreen)
    set -l blue (set_color brblue)
    set -l brred (set_color brred)
    set -l normal (set_color normal)

    set -l git_branch (_git_branch_name)
    if test -n "$git_branch"
        set git_branch "  $git_branch"

        # truncate branch name to 15 characters + prefix
        if test (string length $git_branch) -gt 16
            set git_branch (string sub -s 1 -l 16 $git_branch)"..."
        end

        set -l ahead 0
        set -l behind 0
        set -l counts (string split \t (_git_ahead_behind))
        if test (count $counts) -eq 2
            string match -qr '^\d+$' $counts[1]; and set behind $counts[1]
            string match -qr '^\d+$' $counts[2]; and set ahead $counts[2]
        end

        set -l status_color $green
        if test $ahead -gt 0 -a $behind -gt 0
            set status_color $brred
        else if test $ahead -gt 0
            set status_color $yellow
        else if test $behind -gt 0
            set status_color $blue
        end

        set git_info "$status_color$git_branch$normal"
    end

    echo $git_info

end

function _python_env

    __auto_source_venv

    set -l color (set_color yellow)
    set -l normal (set_color normal)
    if test -n "$VIRTUAL_ENV"
        set -l python_version (string split ' ' (python --version))[2]
        set -l python_version "󰌠 $python_version"
        echo -ns " $color $python_version$normal"
    end
end

function humantime --argument-names ms --description "Turn milliseconds into a human-readable string"
    set --query ms[1] || return

    set --local secs (math --scale=1 $ms/1000 % 60)
    set --local mins (math --scale=0 $ms/60000 % 60)
    set --local hours (math --scale=0 $ms/3600000)

    test $hours -gt 0 && set --local --append out $hours"h"
    test $mins -gt 0 && set --local --append out $mins"m"
    test $secs -gt 0 && set --local --append out $secs"s"

    set --query out && echo $out || echo $ms"ms"
end

function _cmd_duration
    if test $CMD_DURATION -gt 100
        set -l duration " "(humantime $CMD_DURATION)
        echo $duration
    end
end

function _exit_status
    set -l last_status $status
    set -g CMD_COUNT (math $CMD_COUNT + 1)

    if test $last_status -gt 0
        echo " "(set_color red)"✘"(set_color normal)
    else if test $CMD_COUNT -gt 1
        echo " "(set_color brgreen)"✔"(set_color normal)
    end
end

function _playground_env
    if test -n "$PLAYGROUND"
        echo -ns (set_color brcyan)"󰡨 "(set_color normal)
    end
end

function fish_right_prompt
    return
end

function fish_prompt
    set -l last_status (_exit_status)
    set -l cmd_duration (_cmd_duration)
    set -l cwd (basename (prompt_pwd))
    set -l git_info (_git_info)
    set -l python_env (_python_env)
    set -l playground_env (_playground_env)

    printf '%s' $playground_env $cwd $python_env $git_info $cmd_duration $last_status ' '
end
