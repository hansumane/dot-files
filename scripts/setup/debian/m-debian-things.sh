#!/usr/bin/env bash
set -e

rm -rf $HOME/.itemp && mkdir -p $HOME/.itemp && cd $HOME/.itemp

# neovim 0.9.4 (vim replacement)
curl -fLO https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
tar xf nvim-linux64.tar.gz
sudo cp -rf ./nvim-linux64/* /usr

# bat 0.24.0 (cat replacement)
curl -fLO https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
sudo apt install -y ./bat-musl_0.24.0_amd64.deb

# hexyl 0.13.1 (hexdump replacement)
curl -fLO https://github.com/sharkdp/hexyl/releases/download/v0.13.1/hexyl-musl_0.13.1_amd64.deb
sudo apt install -y ./hexyl-musl_0.13.1_amd64.deb

# eza 0.16.0 (exa > ls replacement)
curl -fLO https://github.com/eza-community/eza/releases/download/v0.16.0/eza_x86_64-unknown-linux-gnu.tar.gz
tar xf eza_x86_64-unknown-linux-gnu.tar.gz
sudo install ./eza /usr/bin

cd - && rm -rf $HOME/.itemp
