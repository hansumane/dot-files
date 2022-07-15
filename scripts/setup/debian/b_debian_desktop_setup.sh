#!/bin/bash
set -e;

echo '
alias updg="sudo apt update && sudo apt full-upgrade -y"' >> ~/.zshrc;
echo 'alias upcl="sudo apt autoremove -y && sudo apt autoclean -y"' >> ~/.zshrc;
echo 'alias updc="updg && upcl"' >> ~/.zshrc;

sudo apt update &&
sudo apt full-upgrade -y &&
sudo apt install -y \
  curl wget git tar nano zsh \
  tmux calc subversion clang \
  zip unzip tar gzip bzip2 xz-utils \
  fonts-noto build-essential;

if (lscpu | grep Intel &> /dev/null); then
  sudo apt install iucode-tool -y;
elif (lscpu | grep AMD &> /dev/null); then
  sudo apt install amd64-microcode -y;
else
  echo "your CPU is neither Intel nor AMD";
fi;

mkdir -p ~/Download; cd ~/Download;
  curl -fLO https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip;
  unzip exa-linux-x86_64-v0.10.1.zip -d exa;
  sudo cp -f ~/Download/exa/bin/exa /usr/bin;
  sudo chown root:root /usr/bin/exa; sudo chmod 755 /usr/bin/exa;
    curl -fLO https://github.com/sharkdp/hexyl/releases/download/v0.10.0/hexyl_0.10.0_amd64.deb;
    sudo apt install ~/Download/hexyl_0.10.0_amd64.deb -y;
  curl -fLO https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_amd64.deb;
  sudo apt install ~/Download/bat_0.21.0_amd64.deb -y;
    curl -fLO https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb;
    sudo apt install ~/Download/nvim-linux64.deb -y;

sudo apt autoremove -y &&
sudo apt autoclean -y;
