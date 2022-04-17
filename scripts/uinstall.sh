#!/bin/sh

cd; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
if [ ! -d ~/.oh-my-zsh/custom/plugins ]; then mkdir ~/.oh-my-zsh/custom/plugins; fi;
cd ~/.oh-my-zsh/custom/plugins;
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git;

rm ~/.oh-my-zsh/custom/themes/*;
cp ~/dot-files/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

if [ ! -d ~/.config ]; then mkdir ~/.config; fi;
# if [ -d ~/.config/kitty ]; then rm -r ~/.config/kitty; fi;

cp -r ~/dot-files/configs/universal/.config/nvim ~/.config;
# cp -r ~/dot-files/configs/universal/.config/kitty ~/.config;
# cp ~/dot-files/configs/universal/.Xresources ~;
cp ~/dot-files/configs/universal/.zshrc ~;
cp ~/dot-files/configs/universal/.p10k.zsh ~/.oh-my-zsh;

if [ ! -d ~/Desktop ]; then mkdir ~/Desktop; fi;
if [ ! -d ~/Downloads ]; then mkdir ~/Downloads; fi;
if [ -d ~/Others ]; then mv ~/Others ~/Others_old; fi;
mkdir ~/Others;

cd ~/Others;
mkdir -p etc Coding Documents Music Pictures/Screenshots Shared Templates Videos;
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
