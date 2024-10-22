# name: nai-plus
# Display the following bits on the left:
# * Current directory name
# * Git branch and dirty state (if inside a git repo)



function _git_branch_ahead
    set -l ahead (command git rev-list --count @{u}..HEAD 2> /dev/null)
    if not string match -qr '^\d+$' $ahead
        echo 0
    else
        echo $ahead
    end
end

function _git_branch_behind
    set -l behind (command git rev-list --count HEAD..@{u} 2> /dev/null)
    if not string match -qr '^\d+$' $behind
        echo 0
    else
        echo $behind
    end
end

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function _git_info
    set -l git_info ""

    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l blue (set_color blue)
    set -l red (set_color red)
    set -l normal (set_color normal)

    if test (functions -q _git_branch_name) -a (set -q (_git_branch_name))
        # truncate branch name to 15 characters
        set -l git_branch "$(_git_branch_name)"

        if test (string length $git_branch) -gt 0
            set git_branch "  $git_branch"
        end
        if test (string length $git_branch) -gt 16
            set git_branch (string sub -s 1 -l 16 $git_branch)
            set git_branch "$git_branch..."
        end

        # Retrieve ahead and behind counts, ensuring they are numbers or fallback to 0
        set -l behind (_git_branch_behind)
        set -l ahead (_git_branch_ahead)
        set -l status_color $green

        if test $ahead -gt 0 -a $behind -gt 0
            set status_color $red
        else if test $ahead -gt 0
            set status_color $yellow
        else if test $behind -gt 0
            set status_color $blue
        else
            set status_color $green
        end

        set git_info "$status_color$git_branch$normal"
    end

    echo $git_info

end

function _python_env
    set -l color (set_color bryellow)
    set -l normal (set_color normal)
    if test -n "$VIRTUAL_ENV"
        set -l python_version (python --version | awk '{print $2}')
        echo -ns " $color $python_version$normal"
    end
    echo ""
end

function fish_prompt
    set -l cwd (basename (prompt_pwd))
    set -l git_info (_git_info)
    set -l pytohn_env (_python_env)

    printf '%s' $cwd $pytohn_env $git_info ' '
end
