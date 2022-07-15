#!/bin/bash
set -e;

sudo echo 'max_parallel_downloads=4
defaultyes=True' >> /etc/dnf/dnf.conf;
sudo dnf install epel-release -y;
# sudo dnf config-manager --add-repo \
#   https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo -y;
sudo dnf update --allowerasing --nobest -y;
sudo dnf autoremove -y;
sudo dnf clean all -y;
sudo dnf update -y;

sudo dnf install \
  curl git zip unzip neovim zsh tmux calc \
  subversion clang java-latest-openjdk -y;

mkdir -p ~/Download; cd ~/Download;
  curl -fLO https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip;
  unzip exa-linux-x86_64-v0.10.1.zip -d exa;
  sudo cp ~/Download/exa/bin/exa /usr/bin;
  sudo chown root:root /usr/bin/exa; sudo chmod 755 /usr/bin/exa;
    curl -fLO https://github.com/sharkdp/hexyl/releases/download/v0.10.0/hexyl-v0.10.0-x86_64-unknown-linux-gnu.tar.gz;
    tar xf hexyl-v0.10.0-x86_64-unknown-linux-gnu.tar.gz;
    sudo cp ~/Download/hexyl-v0.10.0-x86_64-unknown-linux-gnu/hexyl /usr/bin;
    sudo chown root:root /usr/bin/hexyl; sudo chmod 755 /usr/bin/hexyl;
      curl -fLO https://github.com/sharkdp/bat/releases/download/v0.21.0/bat-v0.21.0-x86_64-unknown-linux-gnu.tar.gz;
      tar xf bat-v0.21.0-x86_64-unknown-linux-gnu.tar.gz;
      sudo cp ~/Download/bat-v0.21.0-x86_64-unknown-linux-gnu/bat /usr/bin;
      sudo chown root:root /usr/bin/bat; sudo chmod 755 /usr/bin/bat;
