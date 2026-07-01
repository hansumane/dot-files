function gg
    if test -f ~/.gitconfig
        set editor (string match -r --groups-only '^\teditor = ([a-zA-Z0-9_\-]+)$' < ~/.gitconfig)
        if set -q ZED_TERM ; and test -n "$ZED_TERM" ; and test -n "$editor"
            sed -i "s/^\teditor = $editor\$/\teditor = zed/" ~/.gitconfig
        end
    end

    lazygit

    if test -f ~/.gitconfig
        if set -q ZED_TERM ; and test -n "$ZED_TERM" ; and test -n "$editor"
            if test "$editor" = "zed"
                sed -i "s/^\teditor = zed\$/\teditor = $EDITOR/" ~/.gitconfig
            else
                sed -i "s/^\teditor = zed\$/\teditor = $editor/" ~/.gitconfig
            end
        end
    end

    cd ..
    cd -
end
