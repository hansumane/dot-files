#!/bin/bash
set -e;

EXA_VERSION=0.10.1
HEXYL_VERSION=0.10.0
BAT_VERSION=0.21.0
NVIM_VERSION=0.7.2

mkdir -p ~/Download/manually; cd ~/Download/manually;
  curl -fLO https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/exa-linux-x86_64-v${EXA_VERSION}.zip;
  unzip exa-linux-x86_64-v${EXA_VERSION}.zip -d exa;
  sudo cp -f ./exa/bin/exa /usr/bin;
  sudo chown root:root /usr/bin/exa; sudo chmod 755 /usr/bin/exa;
    curl -fLO https://github.com/sharkdp/hexyl/releases/download/v${HEXYL_VERSION}/hexyl_${HEXYL_VERSION}_amd64.deb;
    sudo apt install ./hexyl_${HEXYL_VERSION}_amd64.deb -y;
  curl -fLO https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb;
  sudo apt install ./bat_${BAT_VERSION}_amd64.deb -y;
    curl -fLO https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.deb;
    sudo apt install ./nvim-linux64.deb -y;
rm -rf ./exa;

sudo apt autoremove -y &&
sudo apt autoclean -y;
