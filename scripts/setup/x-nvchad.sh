#!/usr/bin/env bash
set -e

rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
rm -rf ~/.config/nvim/.git ~/.config/nvim/LICENSE ~/.config/nvim/README.md
