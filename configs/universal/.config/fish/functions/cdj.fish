function cdj
    if test (count $argv) -eq 0
        set -f max_depth 1
    else
        set -f max_depth "$argv[1]"
    end

    while true
        _cl_

        if not set -f dir (fd -H -I -td -tl -d "$max_depth" . |
                           fzf --height=50% --layout reverse --bind 'tab:accept')
            break
        end

        if not test -d "$dir"
            echo "'$dir' is not a directory!" >&2
            return 1
        end

        cd (readlink -f "$dir")
    end
end
