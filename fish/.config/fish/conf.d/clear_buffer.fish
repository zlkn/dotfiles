function __fish_clear_buffer
    for line in (seq 5 (tput lines))
        printf "$line"
    end
    printf "\033[H\033[2J"
end
