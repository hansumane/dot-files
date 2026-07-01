function rr
    if command -q sudo
        sudo rm -rf $argv
    else if command -q doas
        doas rm -rf $argv
    else
        rm -rf $argv
    end
end
