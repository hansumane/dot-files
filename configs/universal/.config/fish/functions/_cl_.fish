function _cl_
    if test "$argv[1]" = tree
        set cmd lt
        set args $argv[2..-1]
    else
        set cmd lx
        set args $argv
    end

    c # cpwd

    if not command -q git
        $cmd $args
        return
    end

    set git_toplevel (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -ne 0
        $cmd $args
        return
    end

    if test -f "$git_toplevel/.hide_ls_git"
        $cmd $args
        return
    end

    $cmd --git $args
end
