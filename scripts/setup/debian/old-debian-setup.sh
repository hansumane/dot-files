#!/usr/bin/env bash
set -e

sudo apt update &&
sudo apt full-upgrade -y &&
sudo apt install -y \
  curl wget git zip unzip tar gzip bzip2 xz-utils \
  tmux tree build-essential python3-pip \
  man-db manpages

mkdir -p ~/Downloads/manually/ && cd ~/Downloads/manually/

curl -fLO 'https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz' &&
tar xf 'nvim-linux64.tar.gz' &&
sudo cp ./nvim-linux64/bin/nvim /bin &&
sudo cp -rf ./nvim-linux64/lib/nvim/ /usr/lib/ &&
sudo cp -rf ./nvim-linux64/share/nvim/ /usr/share/

curl -fL https://deb.nodesource.com/setup_16.x -o ~/setup_node.sh &&
chmod +x ~/setup_node.sh && sudo ~/setup_node.sh && rm -f ~/setup_node.sh

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg > /dev/null &&
echo 'deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main' | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update &&
sudo apt install -y nodejs yarn

sudo apt autoremove -y &&
sudo apt autoclean -y

echo 'LC_COLLATE="C"' | sudo tee -a /etc/default/locale
