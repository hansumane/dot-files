#!/usr/bin/env bash
set -e

if command -v btop &> /dev/null; then

  DIR="$HOME"/.config/btop

  rm -rf "$DIR"
  mkdir -p "$DIR"/temp "$DIR"/themes
  cd "$DIR"/temp

  git clone --depth=1 --recursive https://github.com/catppuccin/btop.git
  mv "$DIR"/temp/btop/themes/* "$DIR"/themes
  rm -rf "$DIR"/temp/btop

  git clone --depth=1 --recursive https://github.com/rose-pine/btop.git
  mv "$DIR"/temp/btop/*.theme "$DIR"/themes
  rm -rf $DIR/temp/btop

  if [[ -d "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/btop" ]] ; then
    cp \
      "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/btop"/*.theme \
      "$DIR"/themes
  else
    git clone --depth=1 --recursive https://github.com/folke/tokyonight.nvim.git btop
    mv "$DIR"/temp/btop/extras/btop/*.theme "$DIR"/themes
    rm -rf $DIR/temp/btop
  fi

  cd && rm -rf $DIR/temp

  btop

fi
