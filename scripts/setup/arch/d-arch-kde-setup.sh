#!/usr/bin/env bash

set -e

if [[ ! $(pwd | rev | cut -d'/' -f4 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'setup' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'arch' ]]; then
  echo 'please go to /scripts/setup/arch folder and run script from there!'; exit 1
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd)
fi

sudo pacman -Sy --needed \
  plasma ark dolphin dolphin-plugins konsole okular emacs \
  kate gwenview elisa spectacle okteta plasma-wayland-session \
  kwalletmanager neochat konversation \
  flatpak xdg-desktop-portal-kde kitty \
  pavucontrol-qt qpwgraph networkmanager-openvpn \
  firefox firefox-i18n-ru \
  zathura zathura-pdf-mupdf zathura-djvu

cp -rf ${CURRENT_DIR}/configs/universal/.config/kitty/ ~/.config/

flatpak update
sudo mkinitcpio -P
sudo update-grub
sudo systemctl enable sddm

# sudo sed 's/Exec=.*/# Exec=\/usr\/bin\/kwalletd5/g' -i /usr/share/dbus-1/services/org.kde.kwalletd5.service
