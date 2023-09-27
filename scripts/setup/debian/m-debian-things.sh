#!/usr/bin/env bash

set -e

mkdir -p $HOME/temp && cd $HOME/temp

# neovim 0.8.3 (vim replacement)
curl -fLO https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
sudo apt install -y ./nvim-linux64.deb

# bat 0.23.0 (cat replacement)
curl -fLO https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-musl_0.23.0_amd64.deb
sudo apt install -y ./bat-musl_0.23.0_amd64.deb

# hexyl 0.13.1 (hexdump replacement)
curl -fLO https://github.com/sharkdp/hexyl/releases/download/v0.13.1/hexyl-musl_0.13.1_amd64.deb
sudo apt install -y ./hexyl-musl_0.13.1_amd64.deb

# eza 0.13.0 (exa > ls replacement)
curl -fLO https://github.com/eza-community/eza/releases/download/v0.13.0/eza_x86_64-unknown-linux-gnu.tar.gz
tar xf eza_x86_64-unknown-linux-gnu.tar.gz
sudo install ./eza /usr/local/bin

cd $HOME && rm -rf $HOME/temp
