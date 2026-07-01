function gitr
    if command -q git
        set git_toplevel (git rev-parse --show-toplevel 2>/dev/null)
        if test $status -eq 0
            cd "$git_toplevel"
        end
    end
end
