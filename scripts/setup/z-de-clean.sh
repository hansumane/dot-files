#!/bin/sh

COLOR_RED=$'\e[31m'
COLOR_GREEN=$'\e[1;32m'
COLOR_RESET=$'\e[0m'

DE_CLEAN_CACHE_IGNORE="bat chromium clangd emacs flatpak kitty lvim mozilla nvim pip\
                       p10k-*"
DE_CLEAN_CONFIG_IGNORE="alacritty bat btop chromium Code doom emacs eza GitKraken kitty\
                        lvim nvim user-dirs* *programmer"
DE_CLEAN_LOCAL_SHARE_IGNORE="containers doom flatpak icons lunarvim lvim nvim *programmer"
DE_CLEAN_LOCAL_STATE_IGNORE="lvim nvim *programmer"

clean_dir () {
  dir="$1"
  ignore="$2"

  cd "$dir"
  for node in $(find . -maxdepth 1 | sort) ; do
    bn="$(basename "$node")"
    fn="$(readlink -f "$node")"
    skip=0

    for i in $ignore ; do
      case "$bn" in
        .|$i) skip=1 ;;
      esac
    done

    if [ $skip -ne 1 ] ; then
      echo "${COLOR_RED}deleting [$bn] $fn...${COLOR_RESET}"
      # sudo rm -rf "$fn"
    else
      echo "skipping [$bn] $fn"
    fi
  done
}

clean_dir ~/.cache "$DE_CLEAN_CACHE_IGNORE"
clean_dir ~/.config "$DE_CLEAN_CONFIG_IGNORE"
clean_dir ~/.local/share "$DE_CLEAN_LOCAL_SHARE_IGNORE"
clean_dir ~/.local/state "$DE_CLEAN_LOCAL_STATE_IGNORE"
