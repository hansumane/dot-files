#!/usr/bin/env bash
set -e

if command -v bat &> /dev/null; then

  DIR="$(bat --config-dir)"
  FILE="$(bat --config-file)"

  rm -rf $DIR
  mkdir -p $DIR/themes
  cd $DIR/themes
  curl -fL \
    https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme \
    -o catppuccin-mocha.tmTheme
  echo '--theme="catppuccin-mocha"' > $FILE
  bat cache --build

fi
