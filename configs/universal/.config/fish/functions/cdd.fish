function cdd
    if test (count $argv) -eq 0
        cd (readlink -f .)
    else
        cd (readlink -f $argv)
    end
end
