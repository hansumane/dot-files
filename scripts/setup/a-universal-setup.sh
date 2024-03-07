#!/usr/bin/env bash
set -e

if [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'setup' ]]; then
  echo 'please go to /scripts/setup/ and run script from there!'; exit 1
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd)
fi

cd; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p ~/.oh-my-zsh/custom/plugins/; cd ~/.oh-my-zsh/custom/plugins/
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-autosuggestions.git

mkdir -p ~/.oh-my-zsh/custom/themes/; cd ~/.oh-my-zsh/custom/themes/
cp -f ${CURRENT_DIR}/themes/zsh_themes/* .

mkdir -p ~/.local/bin/ ~/.config/nvim/
cp -f ${CURRENT_DIR}/scripts/newup.sh ~
cp -f ${CURRENT_DIR}/configs/universal/.zshrc ~
cp -f ${CURRENT_DIR}/configs/universal/.gitconfig ~
cp -f ${CURRENT_DIR}/configs/universal/.tmux.conf ~
cp -rf ${CURRENT_DIR}/configs/universal/.config/doom/ ~/.config/

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
# cp -f ${CURRENT_DIR}/configs/universal/.vimrc ~/.config/nvim/init.vim
# sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
#   --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

# tpm (tmux plugin manager; prefix + I - install; prefix + U - update)
git clone --depth=1 --recursive \
  https://github.com/tmux-plugins/tpm \
  ~/.tmux/plugins/tpm
