# name: nai-plus
# Display the following bits on the left:
# * Current directory name
# * Git branch and dirty state (if inside a git repo)

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_right_prompt
end

function fish_prompt
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l normal (set_color normal)
    set -l red (set_color red)

    set -l cwd (basename (prompt_pwd))

    # echo -e ""

    echo -n -s '' $cwd $normal

    if [ (_git_branch_name) ]

        # truncate branch name to 15 characters
        set -l git_branch (_git_branch_name)
        if [ (string length $git_branch) -gt 15 ]
            set git_branch (string sub -s 1 -l 15 $git_branch)
            set git_branch $git_branch'...'
        end

        if [ (_git_dirty) ]
            set git_info $yellow '  ' $git_branch
        else
            set git_info $green '  ' $git_branch
        end
        echo -n -s $git_info $normal
    end

    echo -n -s ' ' $normal

end
