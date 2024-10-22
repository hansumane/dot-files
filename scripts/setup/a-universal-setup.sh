#!/usr/bin/env bash
set -e

if [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'setup' ]]; then
  echo 'please go to /scripts/setup/ and run script from there!'
  exit 1
else
  cd $(git rev-parse --show-toplevel)
  CURRENT_DIR=$(pwd)
fi

# install oh-my-zsh
cd; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install plugins for oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/plugins; cd ~/.oh-my-zsh/custom/plugins
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-autosuggestions.git
git clone --depth=1 --recursive https://github.com/jeffreytse/zsh-vi-mode.git

# install themes for oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/themes; cd ~/.oh-my-zsh/custom/themes
git clone --depth=1 --recursive https://github.com/romkatv/powerlevel10k.git
cp -f ${CURRENT_DIR}/themes/zsh_themes/* .

# install configs
mkdir -p ~/.config ~/.local/bin
cp -f ${CURRENT_DIR}/scripts/newup.sh ~
cp -f ${CURRENT_DIR}/configs/universal/.zshrc ~
cp -f ${CURRENT_DIR}/configs/universal/.gitconfig ~
cp -f ${CURRENT_DIR}/configs/universal/.tmux.conf ~
cp -rf ${CURRENT_DIR}/configs/universal/.config/doom ~/.config

case $OSTYPE in
  *linux-gnu*)
    mkdir -p ~/Desktop ~/Downloads ~/Others; cd ~/Others
    mkdir -p etc Coding Documents Music Pictures Shared Templates Videos

    printf '%s' \
      'XDG_DESKTOP_DIR="$HOME/Desktop"' $'\n' \
      'XDG_DOWNLOAD_DIR="$HOME/Downloads"' $'\n' \
      'XDG_TEMPLATES_DIR="$HOME/Others/Templates"' $'\n' \
      'XDG_PUBLICSHARE_DIR="$HOME/Others/Shared"' $'\n' \
      'XDG_DOCUMENTS_DIR="$HOME/Others/Documents"' $'\n' \
      'XDG_MUSIC_DIR="$HOME/Others/Music"' $'\n' \
      'XDG_PICTURES_DIR="$HOME/Others/Pictures"' $'\n' \
      'XDG_VIDEOS_DIR="$HOME/Others/Videos"' $'\n' > ~/.config/user-dirs.dirs
    ;;

  *linux-android*)
    mkdir -p ~/Downloads ~/Others/Coding ~/Others/Documents
    ;;

  *darwin*)
    mkdir -p ~/Others/Coding
    ;;
esac
