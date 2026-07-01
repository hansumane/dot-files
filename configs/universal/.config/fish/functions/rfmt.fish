function rfmt
    if test (count $argv) -eq 0
        echo 'ERROR: No source file given'
        return 1
    end

    set -l path "$argv[1]"

    if not test -f "$path"
        echo "ERROR: No such file: $path"
        return 1
    end

    rustfmt --check --edition=2024 "$path" | bat --tabs=4 --paging=never
end
