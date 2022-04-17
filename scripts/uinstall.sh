#!/usr/bin/bash
set -e

cd;
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
cd ~/.oh-my-zsh/custom/plugins;
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git;

cd;
rm ~/.oh-my-zsh/custom/themes/example.zsh-theme;
cp ~/dot-files/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cd; if [ ! -d "$(pwd)/.config" ]; then mkdir ~/.config; fi;
# if [ -d "$(pwd)/.config/kitty" ]; then rm -rf ~/.config/kitty; fi;

cp -r ~/dot-files/configs/universal/.config/nvim ~/.config;
# cp -r ~/dot-files/configs/universal/.config/kitty ~/.config;
# cp ~/dot-files/configs/universal/.Xresources ~;
cp ~/dot-files/configs/universal/.zshrc ~;
cp ~/dot-files/configs/universal/.p10k.zsh ~;

cd; if [ ! -d "$(pwd)/Desktop" ]; then mkdir Desktop; fi;
if [ ! -d "$(pwd)/Downloads" ]; then mkdir Downloads; fi;
if [ -d "$(pwd)/Others" ]; then mv Others Others_old; fi;
mkdir Others;

cd ~/Others;
mkdir -p Coding Documents Music Pictures/Screenshots Shared Templates Videos;
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Others/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Others/Shared"
XDG_DOCUMENTS_DIR="$HOME/Others/Documents"
XDG_MUSIC_DIR="$HOME/Others/Music"
XDG_PICTURES_DIR="$HOME/Others/Pictures"
XDG_VIDEOS_DIR="$HOME/Others/Videos"' > ~/.config/user-dirs.dirs;

cd ~/.config/nvim;
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
