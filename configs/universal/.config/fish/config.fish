fish_add_path --prepend /sbin
fish_add_path --prepend /bin
fish_add_path --prepend /usr/sbin
fish_add_path --prepend /usr/bin
fish_add_path --prepend /usr/local/sbin
fish_add_path --prepend /usr/local/bin
fish_add_path --prepend /usr/local/go/bin
fish_add_path --prepend ~/.local/share/nvim/mason/bin
fish_add_path --prepend ~/.local/zed.app/bin
fish_add_path --prepend ~/.cargo/bin
fish_add_path --prepend ~/.nimble/bin
fish_add_path --prepend ~/.local/bin

if status is-interactive
    set -U fish_greeting
    set -gx EDITOR nvim
    if not string match -q "*screen*" "$TERM"
        set -gx TERM xterm-256color
    end

    alias q='exit'
    alias v="$EDITOR"
    alias vd="$EDITOR ."
    alias clx='_cl_'
    alias cxl='_cl_'
    alias glx='_cl_ --git'
    alias gxl='_cl_ --git'
    alias clt='_cl_ tree'
    alias glt='_cl_ tree --git'

    source ~/.config/fzf/catppuccin-mocha.fish
    fzf --fish | source

    starship init fish | source
else
    :
end
