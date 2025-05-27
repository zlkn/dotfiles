function git-mrproper
    if test (count $argv) -ne 1
        echo "Usage: git-clean-branches <branch-to-keep>"
        return 1
    end

    set keep_branch $argv[1]

    # Confirm the branch exists
    if not git show-ref --verify --quiet refs/heads/$keep_branch
        echo "Branch '$keep_branch' does not exist locally."
        return 1
    end

    # Delete all branches except the one to keep
    for branch in (git branch | sed 's/..//' | grep -v "^$keep_branch$")
        echo "Deleting branch: $branch"
        git branch -D $branch
    end
end
