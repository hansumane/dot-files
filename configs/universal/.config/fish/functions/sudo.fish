function sudo
    /usr/bin/sudo /usr/bin/env \
        PATH="$PATH" \
        PYTHONDONTWRITEBYTECODE="$PYTHONDONTWRITEBYTECODE" \
        $argv
end
