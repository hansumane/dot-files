function bip
    if command -q sudo
        sudo ip --color=always $argv
    else if command -q doas
        doas ip --color=always $argv
    else
        ip --color=always $argv
    end
end
