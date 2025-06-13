#!/usr/bin/env bash
set -e

if [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'setup' ]]; then
  echo 'please go to /scripts/setup/ and run script from there!'
  exit 1
else
  cd "$(git rev-parse --show-toplevel)"
  CURRENT_DIR="$(pwd)"
fi

case $OSTYPE in
  *linux-android*)
    pkg install -y \
      curl wget git zip unzip tar gzip bzip2 xz-utils \
      neovim zsh eza bat hexyl calc tmux gnupg which \
      binutils clang python nodejs yarn openssh \
      getconf man manpages -y
    ;;
esac

# install oh-my-zsh
cd; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install plugins for oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/plugins; cd ~/.oh-my-zsh/custom/plugins
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-autosuggestions.git
git clone --depth=1 --recursive https://github.com/jeffreytse/zsh-vi-mode.git

# install themes for oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/themes; cd ~/.oh-my-zsh/custom/themes
git clone --depth=1 --recursive https://github.com/romkatv/powerlevel10k.git
cp -f  ${CURRENT_DIR}/themes/zsh_themes/* .

# install configs
mkdir -p ~/.local/bin ~/.config/nvim
cp -f  ${CURRENT_DIR}/scripts/newup.sh ~
cp -f  ${CURRENT_DIR}/configs/universal/.zshrc ~
cp -f  ${CURRENT_DIR}/configs/universal/.gitconfig ~
cp -f  ${CURRENT_DIR}/configs/universal/.tmux.conf ~
cp -f  ${CURRENT_DIR}/configs/universal/.editorconfig ~
cp -rf ${CURRENT_DIR}/configs/universal/.config/nvim/* ~/.config/nvim

case $OSTYPE in
  *linux-gnu*)
    cp -rf ${CURRENT_DIR}/configs/universal/.config/doom ~/.config

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
    rm -f ~/../usr/etc/motd.sh
    mkdir -p ~/.termux ~/Downloads ~/Others/Coding ~/Others/Documents

    cp -f  ${CURRENT_DIR}/.termux/font.ttf ~/.termux
    cp -f  ${CURRENT_DIR}/.termux/termux.properties ~/.termux
    cp -f  ${CURRENT_DIR}/.termux/colors.properties ~/.termux
    ;;

  *darwin*)
    cp -rf ${CURRENT_DIR}/configs/universal/.config/doom ~/.config

    mkdir -p ~/Others/Coding
    ;;
esac
