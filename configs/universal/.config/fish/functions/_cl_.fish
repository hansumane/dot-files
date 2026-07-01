function _cl_
    if test "$argv[1]" = tree
        set -f cmd lt
        set -f args $argv[2..-1]
    else
        set -f cmd lx
        set -f args $argv
    end

    c # cpwd

    if not command -q git
        $cmd $args
        return
    end

    set -l git_toplevel (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -ne 0
        $cmd $args
        return
    end

    if test -f "$git_toplevel/.nogit"
        $cmd $args
        return
    end

    $cmd --git $args
end
