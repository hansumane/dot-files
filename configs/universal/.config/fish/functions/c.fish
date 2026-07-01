function c
    if command -q clear
        clear
    else
        printf "\033[H\033[J"
    end

    if string match -q "*screen*" "$TERM"
        tmux clear-history
    end
end
