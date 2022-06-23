#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d"/" -f3 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d"/" -f2 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d"/" -f1 | rev) = 'setup' ]; then
  echo "please go to ?/dot-files/scripts/setup folder and run script from there!";
  exit;
else
  cd ../..;
  CURRENT_DIR=$(pwd);
fi;

sudo pacman -Syy --needed --noconfirm \
  curl git zip unzip neovim zsh exa bat hexyl tmux calc \
  subversion clang neofetch jdk-openjdk jre-openjdk;

sudo pacman -S --needed --noconfirm \
  wireplumber pipewire pipewire-alsa pipewire-pulse pipewire-jack;

sudo pacman -S --needed --noconfirm \
  xorg xorg-xwayland wayland;

sudo pacman -S --needed --noconfirm \
  noto-fonts noto-fonts-cjk noto-fonts-emoji;

mkdir -p ~/Downloads; cd ~/Downloads;
git clone --depth=1 https://aur.archlinux.org/yay.git;
cd ~/Downloads/yay; makepkg -sic;
cd; rm -rf ~/Downloads/yay;

# installing update-grub
if [ ! -f /usr/bin/system-update ]; then
  sudo cp -f ${CURRENT_DIR}/scripts/system-update-arch /usr/bin/system-update;
  sudo chown root:root /usr/bin/system-update;
fi;
