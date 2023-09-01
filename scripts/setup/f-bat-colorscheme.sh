#!/usr/bin/env bash

set -e

if command -v bat &> /dev/null; then

  DIR="$(bat --config-dir)"
  FILE="$(bat --config-file)"

  rm -rf $DIR
  mkdir -p $DIR/themes
  cd $DIR/themes
  curl -fLO https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-macchiato.tmTheme
  echo '--theme="Catppuccin-macchiato"' > $FILE
  bat cache --build

fi
