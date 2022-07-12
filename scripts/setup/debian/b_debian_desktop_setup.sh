#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f4 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'setup' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'debian' ]; then
  echo "please go to ?/dot-files/scripts/setup folder and run script from there!";
  exit 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
fi;

sudo apt update &&
sudo apt full-upgrade -y &&
sudo apt autoremove -y &&
sudo apt autoclean -y;

sudo apt install -y \
  curl git zip unzip vim zsh tmux \
  subversion clang;

sudo apt install -y \
  pulseaudio;

sudo apt install -y \
  xorg xinit xwayland wayland-protocols;

sudo apt install -y \
  fonts-noto;

if (lscpu | grep Intel > /dev/null); then
  sudo apt install iucode-tool -y;
elif (lscpu | grep AMD > /dev/null); then
  sudo apt install amd64-microcode -y;
else
  echo "your CPU is neither Intel nor AMD";
fi;
