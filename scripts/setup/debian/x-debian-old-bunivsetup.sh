#!/usr/bin/env bash

set -e

if [[ ! $(pwd | rev | cut -d'/' -f4 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'setup' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'debian' ]]; then
  echo 'please go to /scripts/setup/debian/ and run script from there!'; exit 1
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd)
fi

mkdir -p ~/.local/bin/ ~/.config/nvim/
cp -f ${CURRENT_DIR}/scripts/newup.sh ~
cp -f ${CURRENT_DIR}/configs/universal/.gitconfig ~
cp -f ${CURRENT_DIR}/configs/universal/.bash* ~
cp -rf ${CURRENT_DIR}/configs/universal/.vimrc ~/.config/nvim/init.vim

mkdir -p ~/Desktop/ ~/Downloads/ ~/Others/; cd ~/Others/
mkdir -p etc/ Coding/ Documents/ Music/ Pictures/ Shared/ Templates/ Videos/
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Others/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Others/Shared"
XDG_DOCUMENTS_DIR="$HOME/Others/Documents"
XDG_MUSIC_DIR="$HOME/Others/Music"
XDG_PICTURES_DIR="$HOME/Others/Pictures"
XDG_VIDEOS_DIR="$HOME/Others/Videos"' > ~/.config/user-dirs.dirs

# vim-plug for neovim (deprecated)
# sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
#   --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
# nvim ~/.gitconfig
