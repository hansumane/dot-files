#!/usr/bin/env bash
set -e

LVIM_UNINSTALL_SCRIPT="$HOME/.local/share/lunarvim/lvim/utils/installer/uninstall.sh"

if [[ -f "$LVIM_UNINSTALL_SCRIPT" ]]; then
  bash "$LVIM_UNINSTALL_SCRIPT"
fi

rm -rf ~/.cache/lvim \
       ~/.config/lvim \
       ~/.local/bin/lvim \
       ~/.local/state/lvim \
       ~/.local/share/lvim \
       ~/.local/share/lunarvim \
       ~/.local/share/lunarvim.old \
       ~/.local/share/applications/lvim.desktop \
       ~/.local/share/icons/hicolor/16x16/apps/lvim.svg \
       ~/.local/share/icons/hicolor/22x22/apps/lvim.svg \
       ~/.local/share/icons/hicolor/24x24/apps/lvim.svg \
       ~/.local/share/icons/hicolor/32x32/apps/lvim.svg \
       ~/.local/share/icons/hicolor/48x48/apps/lvim.svg \
       ~/.local/share/icons/hicolor/64x64/apps/lvim.svg

if [[ "$LVIM_NIGHTLY" = "y" ]]; then
  echo "Installing LunarVim nightly"
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
else
  echo "Installing LunarVim release"
  LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
fi
