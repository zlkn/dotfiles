# Show only basename of current directory in tabbar
function fish_title
    set -q argv[1]; or set argv ""
    echo (basename (prompt_pwd)) $argv
end
