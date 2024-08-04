#!/usr/bin/env bash
set -e

sudo apt update
sudo apt full-upgrade -y
sudo apt install -y \
  curl wget git zip unzip tar gzip bzip2 xz-utils \
  zsh tmux calc clang clangd build-essential python3-pip \
  man-db manpages

echo 'LC_COLLATE="C"' | sudo tee -a /etc/default/locale
