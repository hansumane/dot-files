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

sudo pacman -Sy --needed \
  curl git zip unzip neovim zsh exa bat hexyl tmux calc \
  subversion clang neofetch jdk-openjdk jre-openjdk \
  man-db man-pages;

sudo pacman -S --needed \
  wireplumber pipewire pipewire-alsa pipewire-pulse pipewire-jack;

sudo pacman -S --needed \
  xorg xorg-xwayland wayland;

sudo pacman -S --needed \
  noto-fonts noto-fonts-cjk noto-fonts-emoji;

if (lscpu | grep Intel &> /dev/null); then
  sudo pacman -S --needed intel-ucode;
elif (lscpu | grep AMD &> /dev/null); then
  sudo pacman -S --needed amd-ucode;
else
  echo "your CPU is neither Intel nor AMD =(";
fi;

mkdir -p ~/Download; cd ~/Download;
git clone --depth=1 --recursive https://aur.archlinux.org/yay-bin.git;
cd ~/Download/yay-bin; makepkg -sic;
cd; rm -rf ~/Download/yay-bin;

yay -Sy --needed \
  hunspell hunspell-en_us hunspell-ru \
  hyphen hyphen-en hyphen-ru;

if [ ! -f /usr/bin/system-update ]; then
  sudo cp -f ${CURRENT_DIR}/scripts/system-update-arch /usr/bin/system-update;
  sudo chown root:root /usr/bin/system-update;
  sudo chmod 755 /usr/bin/system-update;
fi;
