fish_add_path --prepend /sbin
fish_add_path --prepend /bin
fish_add_path --prepend /usr/sbin
fish_add_path --prepend /usr/bin
fish_add_path --prepend /usr/local/sbin
fish_add_path --prepend /usr/local/bin
fish_add_path --prepend /usr/local/bin
fish_add_path --prepend ~/.go/bin
fish_add_path --prepend ~/.cargo/bin
fish_add_path --prepend ~/.nimble/bin
fish_add_path --prepend ~/.local/bin
fish_add_path --prepend ~/.local/share/nvim/mason/bin

set -gx EDITOR nvim

alias q='exit'
alias v="$EDITOR"
alias vd="$EDITOR ."
alias clx='_cl_'
alias cxl='_cl_'
alias clt='_cl_ tree'

if status is-interactive
    set -U fish_greeting

    if not string match -q "*screen*" "$TERM"
        set -gx TERM xterm-256color
    end

    starship init fish | source

    source ~/.config/fzf/catppuccin-mocha.fish
    fzf --fish | source
else
    :
end
