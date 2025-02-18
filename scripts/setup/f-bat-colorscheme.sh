#!/usr/bin/env bash
set -e

PROMPT="\
Choose theme [1]:
1. Catppuccin Mocha
"

if command -v bat &> /dev/null; then

  DIR="$(bat --config-dir)"
  FILE="$(bat --config-file)"

  rm -rf "$DIR"
  mkdir -p "$DIR"/themes
  cd "$DIR"/themes

  read -p "$PROMPT" CHOICE
  CHOICE=${CHOICE:-1}

  case "$CHOICE" in
    *1*)
      THEME="catppuccin-mocha"
      curl -fL \
        https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme \
        -o "$THEME".tmTheme
      ;;
  esac

  echo "--theme=\"$THEME\"" > "$FILE"
  bat cache --build

fi
