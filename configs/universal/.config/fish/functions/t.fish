function t
    cd
    if test (count $argv) -eq 0
        tmux -u new-session -A -s ' '
    else
        tmux -u new-session -A -s $argv
    end
    cd -
end
