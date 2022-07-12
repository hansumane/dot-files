#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f4 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'setup' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'others' ]; then
  echo "please go to ?/dot-files/scripts/setup folder and run script from there!";
  return 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
fi;


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


mkdir -p ~/Downloads; cd ~/Downloads;

curl -fLO https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip;
unzip exa-linux-x86_64-v0.10.1.zip -d exa;
sudo cp ~/Downloads/exa/bin/exa /usr/bin;
sudo chown root:root /usr/bin/exa; sudo chmod 755 /usr/bin/exa;

curl -fLO https://github.com/sharkdp/hexyl/releases/download/v0.10.0/hexyl-v0.10.0-x86_64-unknown-linux-gnu.tar.gz;
tar xf hexyl-v0.10.0-x86_64-unknown-linux-gnu.tar.gz;
sudo cp ~/Downloads/hexyl-v0.10.0-x86_64-unknown-linux-gnu/hexyl /usr/bin;
sudo chown root:root /usr/bin/hexyl; sudo chmod 755 /usr/bin/hexyl;

curl -fLO https://github.com/sharkdp/bat/releases/download/v0.21.0/bat-v0.21.0-x86_64-unknown-linux-gnu.tar.gz;
tar xf bat-v0.21.0-x86_64-unknown-linux-gnu.tar.gz;
sudo cp ~/Downloads/bat-v0.21.0-x86_64-unknown-linux-gnu/bat /usr/bin;
sudo chown root:root /usr/bin/bat; sudo chmod 755 /usr/bin/bat;
