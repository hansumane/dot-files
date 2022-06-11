#!/bin/bash
set -e;

sudo pacman -Syy --needed \
  curl git zip unzip neovim zsh exa bat hexyl tmux calc;

sudo pacman -S --needed \
  wireplumber pipewire pipewire-alsa pipewire-pulse pipewire-jack;

sudo pacman -S --needed \
  xorg xorg-xwayland wayland;

sudo pacman -S --needed \
  noto-fonts noto-fonts-cjk noto-fonts-emoji;

mkdir -p ~/Downloads; cd ~/Downloads;
git clone --depth=1 https://aur.archlinux.org/yay.git;
cd ~/Downloads/yay; makepkg -sic;
cd; rm -rf ~/Downloads/yay;
