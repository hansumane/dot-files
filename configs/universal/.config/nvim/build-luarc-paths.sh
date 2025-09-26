#!/bin/sh
# shellcheck disable=2016
readlink -f ~/.local/share/nvim/lazy/*/lua \
  | sed -E 's/^.*share\/nvim\/(.*)$/      "$XDG_DATA_HOME\/nvim\/\1",/' \
  | sed '$ s/,$//'
