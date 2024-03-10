#!/usr/bin/env bash
set -e

if [[ ! $(pwd | rev | cut -d'/' -f4 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'setup' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'arch' ]]; then
  echo 'please go to /scripts/setup/arch folder and run script from there!'
  exit 1
else
  cd $(git rev-parse --show-toplevel)
  CURRENT_DIR=$(pwd)
fi

sudo pacman -Sy --needed \
  plasma ark dolphin dolphin-plugins okular emacs kitty alacritty \
  kate gwenview elisa spectacle okteta plasma-wayland-protocols \
  kwalletmanager neochat konversation xwaylandvideobridge inter-font \
  flatpak xdg-desktop-portal-kde xdg-desktop-portal \
  pavucontrol-qt qpwgraph networkmanager-openvpn \
  firefox firefox-i18n-ru zathura zathura-pdf-mupdf zathura-djvu \
  tesseract-data-eng tesseract-data-rus

cp -rf ${CURRENT_DIR}/configs/universal/.config/kitty ~/.config
cp -rf ${CURRENT_DIR}/configs/universal/.config/alacritty ~/.config

flatpak update
set +e
sudo mkinitcpio -P
set -e
sudo update-grub
sudo systemctl enable sddm
