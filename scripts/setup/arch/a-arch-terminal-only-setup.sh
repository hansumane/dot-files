#!/usr/bin/env bash

set -e

if [[ ! $(pwd | rev | cut -d'/' -f4 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'setup' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'arch' ]]; then
  echo 'please go to /scripts/setup/arch folder and run script from there!'
  exit 1
else
  cd $(git rev-parse --show-toplevel)
  CURRENT_DIR=$(pwd)
fi

sudo pacman -Sy --needed \
  curl lazygit git zip unzip tar gzip bzip2 xz \
  neovim zsh exa bat btop hexyl

if ( lscpu | grep Intel &> /dev/null ); then
  sudo pacman -S --needed intel-ucode
elif ( lscpu | grep AMD &> /dev/null ); then
  sudo pacman -S --needed amd-ucode
else
  echo 'your CPU is neither Intel nor AMD =['
fi

sudo pacman -S --needed \
  tmux calc tree openssh man-db man-pages npm \
  neofetch base-devel clang cmake colorgcc nodejs \
  wireguard-tools jdk17-openjdk jre17-openjdk \
  indent python-pip

mkdir -p ~/Downloads; cd ~/Downloads
git clone --depth=1 --recursive https://aur.archlinux.org/yay-bin.git
cd ~/Downloads/yay-bin; makepkg -sic
cd; rm -rf ~/Downloads/yay-bin

if [[ -d /usr/sbin ]]; then
  if [[ ! -f /usr/sbin/update-grub ]]; then
    sudo cp -f ${CURRENT_DIR}/scripts/update-grub /usr/sbin
    sudo chown root:root /usr/sbin/update-grub
    sudo chmod 755 /usr/sbin/update-grub
  fi
else
  if [[ ! -f /usr/bin/update-grub ]]; then
    sudo cp -f ${CURRENT_DIR}/scripts/update-grub /usr/bin
    sudo chown root:root /usr/bin/update-grub
    sudo chmod 755 /usr/bin/update-grub
  fi
fi
