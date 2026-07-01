function gfmt
    if test (count $argv) -eq 0
        echo 'ERROR: No source file given'
        return 1
    end

    set path "$argv[1]"

    if not test -f "$path"
        echo "ERROR: No such file: $path"
        return 1
    end

    set temp_fn "$(basename "$argv[1]" .go)~.go"
    gofmt "$path" > "$temp_fn"
    diff -u "$path" "$temp_fn" | bat --tabs=4 --paging=never
    rm -f "$temp_fn"
end
