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

function fish_prompt
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l blue (set_color blue)
    set -l red (set_color red)
    set -l normal (set_color normal)

    set -l cwd (basename (prompt_pwd))

    echo -ns ' ' $cwd $normal

    if test (functions -q _git_branch_name) -a (set -q (_git_branch_name))
        # truncate branch name to 15 characters
        set -l git_branch "$(_git_branch_name)"

        if test (string length $git_branch) -gt 0
            set git_branch "  $git_branch"
        end
        if test (string length $git_branch) -gt 15
            set git_branch (string sub -s 1 -l 15 $git_branch)
            set git_branch " $git_branch..."
        end

        # Retrieve ahead and behind counts, ensuring they are numbers or fallback to 0
        set -l behind (_git_branch_behind)
        set -l ahead (_git_branch_ahead)

        if test $ahead -gt 0 -a $behind -gt 0
            set status_color $red
        else if test $ahead -gt 0
            set status_color $blue
        else if test $behind -gt 0
            set status_color $yellow
        else
            set status_color $green
        end

        set git_info "$status_color$git_branch$normal "
    end

    echo -ns ' ' $git_info
end
