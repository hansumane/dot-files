#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f4 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'setup' ]; then
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'debian' ]; then
  echo "please go to /scripts/setup/debian folder and run script from there!";
  exit 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
fi;

cd; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
mkdir -p ~/.oh-my-zsh/custom/plugins; cd ~/.oh-my-zsh/custom/plugins;
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone --depth=1 --recursive https://github.com/zsh-users/zsh-autosuggestions.git;

mkdir -p ~/.oh-my-zsh/custom/themes; cd ~/.oh-my-zsh/custom/themes;
cp -f ${CURRENT_DIR}/themes/zsh_themes/* .;

mkdir -p ~/.config;
cp -f ${CURRENT_DIR}/configs/universal/.gitconfig ~;
cp -f ${CURRENT_DIR}/configs/universal/.zshrc ~;
cp -f ${CURRENT_DIR}/configs/universal/.vimrc ~;

mkdir -p ~/Desktop ~/Downloads ~/Others; cd ~/Others;
mkdir -p etc Coding Documents Music Pictures Shared Templates Videos;
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Others/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Others/Shared"
XDG_DOCUMENTS_DIR="$HOME/Others/Documents"
XDG_MUSIC_DIR="$HOME/Others/Music"
XDG_PICTURES_DIR="$HOME/Others/Pictures"
XDG_VIDEOS_DIR="$HOME/Others/Videos"' > ~/.config/user-dirs.dirs;

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;

vim ~/.gitconfig || nano ~/.gitconfig;
sudo chsh -s /bin/zsh $(whoami);
