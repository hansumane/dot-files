#!/usr/bin/env bash
set -e
shopt -s globstar

(( EUID == 0 )) && SUDO= || SUDO=sudo

PREFIX="/usr/local"

REMOVE_NVIM="no"
REMOVE_NVIM_LOCAL="no"

REMOVE_VIM="no"
REMOVE_VIM_LOCAL="no"

REMOVE_FILES=()

if [[ "x$REMOVE_NVIM" = "xyes" ]] ; then
  REMOVE_FILES+=(
    "$PREFIX/bin/nvim" "$PREFIX/lib/nvim" "$PREFIX/share/applications/nvim.desktop"
    "$PREFIX/share/icons/hicolor/128x128/apps/nvim.png" "$PREFIX/share/man/man1/nvim.1"
    "$PREFIX/share/nvim"
  )
fi

if [[ "x$REMOVE_NVIM_LOCAL" = "xyes" ]] ; then
  REMOVE_FILES+=(
    "$HOME/.cache/nvim" "$HOME/.local/share/nvim" "$HOME/.local/state/nvim"
  )
fi

if [[ "x$REMOVE_VIM" = "xyes" ]] ; then
  REMOVE_FILES+=(
    "$PREFIX/bin/ex" "$PREFIX/bin/rview" "$PREFIX/bin/rvim" "$PREFIX/bin/vi"
    "$PREFIX/bin/view" "$PREFIX/bin/vim" "$PREFIX/bin/vimdiff" "$PREFIX/bin/vimtutor"
    "$PREFIX/share/applications/gvim.desktop" "$PREFIX/share/applications/vim.desktop"
    "$PREFIX/share/icons/hicolor/48x48/apps/gvim.png"
    "$PREFIX/share/icons/locolor/16x16/apps/gvim.png"
    "$PREFIX/share/icons/locolor/32x32/apps/gvim.png"
    "$PREFIX/share/vim"
  )

  for file in "$PREFIX/share/man/"**/{evim,ex,rview,rvim,view,vim,vimdiff,vimtutor}.* ; do
    REMOVE_FILES+=("$file")
  done
fi

if [[ "x$REMOVE_VIM_LOCAL" = "xyes" ]] ; then
  REMOVE_FILES+=(
    "$HOME/.vim" "$HOME/.viminfo" "$HOME/.local/share/vim-lsp-settings"
  )
fi

for file in "${REMOVE_FILES[@]}" ; do
  if [[ -f "$file" ]] ; then
    echo "found file: '$file'"
    $SUDO rm -f "$file"
  elif [[ -d "$file" ]] ; then
    echo "found dir: '$file'"
    $SUDO rm -rf "$file"
  elif [[ -L "$file" ]] ; then
    echo "found link: '$file'"
    $SUDO unlink "$file"
  else
    echo "no such file, link or dir: '$file'"
  fi
done
