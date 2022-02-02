#!/data/data/com.termux/files/usr/bin/sh

pkg upgrade -y;
pkg install root-repo curl wget git zip unzip tar nano vim neovim binutils clang python zsh exa hexyl gnupg openssh -y;
pkg install tsu -y;

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
cd ~/.oh-my-zsh/custom/plugins;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone https://github.com/zsh-users/zsh-autosuggestions.git;

cp ~/storage/dot-files/.termux/font.ttf ~/.termux;
cp ~/storage/dot-files/.termux/*.properties ~/.termux;
cp ~/storage/dot-files/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;
rm ~/.oh-my-zsh/custom/themes/example.zsh-theme;

if [ ! -d "$HOME/.config" ]; then mkdir ~/.config; fi;
cp -r ~/storage/dot-files/.termux/.config/nvim ~/.config;
cp ~/storage/dot-files/.termux/.zshrc ~;
