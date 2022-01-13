sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
cd ~/.oh-my-zsh/custom/plugins &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git;
# I'm not using zsh-autosuggestions temporarily...
# git clone https://github.com/zsh-users/zsh-autosuggestions.git;
cd; git clone https://github.com/sindresorhus/pure.git &&
cd pure &&
cat pure.zsh > ~/.oh-my-zsh/custom/themes/pure.zsh-theme &&
mkdir ~/.oh-my-zsh/functions &&
cat async.zsh > ~/.oh-my-zsh/functions/async &&
cd && rm -rf pure;
cp ~/dot-files/zshthemes/* ~/.oh-my-zsh/custom/themes &&
rm -rf ~/.oh-my-zsh/custom/themes/example.zsh-theme;
mkdir ~/.config &&
cp -rf ~/dot-files/configs/universal/.config/nvim ~/.config &&
cp -rf ~/dot-files/configs/universal/.zshrc ~;
cd; mkdir Desktop Downloads Others && cd Others &&
mkdir -p Templates Shared Documents Music Pictures/Screenshots Videos &&
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Others/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Others/Shared"
XDG_DOCUMENTS_DIR="$HOME/Others/Documents"
XDG_MUSIC_DIR="$HOME/Others/Music"
XDG_PICTURES_DIR="$HOME/Others/Pictures"
XDG_VIDEOS_DIR="$HOME/Others/Videos"' > ~/.config/user-dirs.dirs &&
echo 'en_US' > ~/.config/user-dirs.locale
