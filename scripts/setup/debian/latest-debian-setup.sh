#!/usr/bin/env bash
set -e

sudo apt update &&
sudo apt full-upgrade -y &&
sudo apt install -y \
  curl git zip unzip tar gzip bzip2 xz-utils \
  zsh tmux calc subversion \
  clang clangd build-essential python3-pip \
  man-db manpages nodejs yarnpkg
sudo apt install npm --no-install-recommends -y

echo 'LC_COLLATE="C"' | sudo tee -a /etc/default/locale
