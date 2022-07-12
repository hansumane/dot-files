#!/data/data/com.termux/files/usr/bin/bash

pkg upgrade -y;
pkg install root-repo curl git zip unzip neovim \
  binutils clang python zsh exa bat hexyl gnupg \
  openssh tmux calc subversion -y;
pkg install tsu -y;

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
cd ~/.oh-my-zsh/custom/plugins;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone https://github.com/zsh-users/zsh-autosuggestions.git;

cp -f ~/storage/dot-files/.termux/font.ttf ~/.termux;
cp -f ~/storage/dot-files/.termux/termux.properties ~/.termux;
cp -f ~/storage/dot-files/.termux/colors.properties ~/.termux;

ln -sf ~/.termux/shell $(which zsh)

cp -f ~/storage/dot-files/configs/universal/.gitconfig ~;
cp -f ~/storage/dot-files/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;

mkdir -p ~/.config/nvim;
cp -f ~/storage/dot-files/.termux/.vimrc ~/.config/nvim/init.vim;
cp -f ~/storage/dot-files/.termux/.zshrc ~;

sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

nvim ~/.gitconfig;
