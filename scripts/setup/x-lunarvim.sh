#!/usr/bin/env bash
set -e

rm -rf ~/.cache/lvim \
       ~/.config/lvim \
       ~/.local/bin/lvim \
       ~/.local/state/lvim \
       ~/.local/share/lvim \
       ~/.local/share/lunarvim \
       ~/.local/share/lunarvim.old \
       ~/.local/share/applications/lvim.desktop

if [[ "$LVIM_NIGHTLY" = "y" ]]; then
  echo "Installing LunarVim nightly"
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
else
  echo "Installing LunarVim release"
  LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
fi
