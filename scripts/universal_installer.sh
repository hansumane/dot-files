#!/bin/bash

cd; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
mkdir -p ~/.oh-my-zsh/custom/plugins;
cd ~/.oh-my-zsh/custom/plugins;
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git;

cp ~/dot-files/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

mkdir -p ~/.config

cp -r ~/dot-files/configs/universal/.gitconfig ~;
cp -r ~/dot-files/configs/universal/.config/nvim ~/.config;
cp ~/dot-files/configs/universal/.zshrc ~;

mkdir -p ~/Desktop ~/Downloads ~/Others;
cd ~/Others;
mkdir -p etc Coding Documents Music Pictures Shared Templates Videos;
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Others/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Others/Shared"
XDG_DOCUMENTS_DIR="$HOME/Others/Documents"
XDG_MUSIC_DIR="$HOME/Others/Music"
XDG_PICTURES_DIR="$HOME/Others/Pictures"
XDG_VIDEOS_DIR="$HOME/Others/Videos"' > ~/.config/user-dirs.dirs;

cd ~/.config/nvim;
sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
