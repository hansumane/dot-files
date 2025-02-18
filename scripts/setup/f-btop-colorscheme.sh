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
  cd && rm -rf $DIR/temp

  btop

fi
