#!/bin/bash
set -e;

# alias updg='sudo apt update && sudo apt full-upgrade -y'
# alias upcl='sudo apt autoremove -y && sudo apt autoclean -y'
# alias updc='updg && upcl'

sudo apt update &&
sudo apt full-upgrade -y &&
sudo apt install -y \
  curl git tar gzip bzip2 xz-utils \
  zip unzip nano tmux zsh calc \
  subversion clang build-essential \
  exa bat hexyl neovim tree;

if (lscpu | grep Intel &> /dev/null); then
  sudo apt install intel-microcode iucode-tool -y;
elif (lscpu | grep AMD &> /dev/null); then
  sudo apt install amd64-microcode -y;
else
  echo "your CPU is neither Intel nor AMD";
fi;

sudo apt autoremove -y &&
sudo apt autoclean -y;
