#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'setup' ]; then
  echo "please go to /scripts/setup folder and run script from there!";
  exit 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
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

if (lscpu | grep Intel > /dev/null); then
  sudo pacman -S --needed --noconfirm intel-ucode;
elif (lscpu | grep AMD > /dev/null); then
  sudo pacman -S --needed --noconfirm amd-ucode;
else
  echo "your CPU is neither Intel nor AMD";
fi;

sudo sed 's/#Color/Color/g' -i /etc/pacman.conf
sudo sed 's/#ParallelDownloads.*/ParallelDownloads = 4/g' -i /etc/pacman.conf

mkdir -p ~/Downloads; cd ~/Downloads;
git clone --depth=1 --recursive https://aur.archlinux.org/yay-bin.git;
cd ~/Downloads/yay-bin; makepkg -sic;
cd; rm -rf ~/Downloads/yay-bin;

if [ ! -f /usr/bin/system-update ]; then
  sudo cp -f ${CURRENT_DIR}/scripts/system-update-arch /usr/bin/system-update;
  sudo chown root:root /usr/bin/system-update;
  sudo chmod 755 /usr/bin/system-update;
fi;
