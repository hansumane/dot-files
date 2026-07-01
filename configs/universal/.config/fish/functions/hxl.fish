function hxl
    _hxl $argv | b
end

function _hxl
    for file in $argv
        echo "$file"
        hexyl "$file"
    end
end
