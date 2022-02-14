#!/data/data/com.termux/files/usr/bin/sh

pkg upgrade -y;
pkg install root-repo curl wget git zip unzip tar vim neovim binutils clang python zsh exa hexyl gnupg openssh ranger termux -y;
pkg install tsu -y;

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
cd ~/.oh-my-zsh/custom/plugins;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git;
git clone https://github.com/zsh-users/zsh-autosuggestions.git;

cp ~/storage/dot-files/.termux/font.ttf ~/.termux;
cp ~/storage/dot-files/.termux/*.properties ~/.termux;

rm ~/.oh-my-zsh/custom/themes/example.zsh-theme;
cp ~/storage/dot-files/themes/zsh_themes/* ~/.oh-my-zsh/custom/themes;
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

if [ ! -d "$HOME/.config" ]; then mkdir ~/.config; fi;
cp -r ~/storage/dot-files/.termux/.config/nvim ~/.config;
cp -f ~/storage/dot-files/.termux/.p10k.zsh ~;
cp ~/storage/dot-files/.termux/.zshrc ~;

cd ~/.config/nvim;
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
