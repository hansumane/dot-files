#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d"/" -f3 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d"/" -f2 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d"/" -f1 | rev) = 'setup' ]; then
  echo "please go to ?/dot-files/scripts/setup folder and run script from there!";
  exit;
else
  cd ../..;
  CURRENT_DIR=$(pwd);
fi;

cd; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
mkdir -p ~/.oh-my-zsh/custom/plugins;
cd ~/.oh-my-zsh/custom/plugins;
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git;

cp -f ${CURRENT_DIR}/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

mkdir -p ~/.config
cp -f ${CURRENT_DIR}/configs/universal/.gitconfig ~;
cp -f ${CURRENT_DIR}/configs/universal/.zshrc ~;
cp -rf ${CURRENT_DIR}/configs/universal/.config/nvim ~/.config;
# cp -f ${CURRENT_DIR}/configs/universal/.vimrc ~;
# cp -f ${CURRENT_DIR}/configs/universal/.p10k.zsh ~;

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

# vim-plug for nvim (neovim)
sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

# vim-plug for classic vim
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# installing update-grub
if [ -d /usr/sbin ]; then
  if [ ! -f /usr/sbin/update-grub ]; then
    sudo cp -f ${CURRENT_DIR}/scripts/update-grub /usr/sbin;
    sudo chown root:root -R /usr/sbin/update-grub;
  fi;
else
  if [ ! -f /usr/bin/update-grub ]; then
    sudo cp -f ${CURRENT_DIR}/scripts/update-grub /usr/bin;
    sudo chown root:root -R /usr/bin/update-grub;
  fi;
fi;

# change .gitconfig and default user shell
nvim ~/.gitconfig || vim ~/.gitconfig || nano ~/.gitconfig;
sudo nvim /etc/passwd || sudo vim /etc/passwd || sudo nano /etc/passwd;
