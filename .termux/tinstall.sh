#!/data/data/com.termux/files/usr/bin/bash

if [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = '.termux' ]; then
  echo "please go to /.termux folder and run script from there!";
  exit 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
fi;

pkg upgrade -y;
pkg install -y \
  curl git tar zip unzio gzip bzip2 xz-utils \
  neovim zsh exa bat hexyl calc tmux gnupg \
  binutis clang python subversion root-repo;
pkg install tsu -y;

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
cd ~/.oh-my-zsh/custom/plugins;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone https://github.com/zsh-users/zsh-autosuggestions.git;

ln -sf $(which zsh) ~/.termux/shell;

mkdir -p ~/.config/nvim;
cp -f ${CURRENT_DIR}/.termux/.vimrc ~/.config/nvim/init.vim;
cp -f ${CURRENT_DIR}/.termux/.zshrc ~;
cp -f ${CURRENT_DIR}/.termux/font.ttf ~/.termux;
cp -f ${CURRENT_DIR}/.termux/termux.properties ~/.termux;
cp -f ${CURRENT_DIR}/.termux/colors.properties ~/.termux;
cp -f ${CURRENT_DIR}/configs/universal/.gitconfig ~;
cp -f ${CURRENT_DIR}/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;

sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

nvim ~/.gitconfig;
