#!/usr/bin/env bash

set -e;

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

yay -Sy --needed \
  gtk2 gtk3 gtk4 qt5-wayland qt6-wayland gtk-engine-murrine \
  hyprland wofi hyprpaper waybar xdg-desktop-portal-hyprland \
  grim slurp lxappearance pavucontrol dolphin kitty alacritty \
  nm-connection-editor network-manager-applet networkmanager-openvpn \
  gnome-themes-extra xdg-desktop-portal-gtk xdg-user-dirs \
  flatpak helvum zathura zathura-pdf-mupdf zathura-djvu \
  libayatana-appindicator libappindicator-gtk3 libappindicator-gtk2 \
  firefox firefox-i18n-ru;

cp -rf ${CURRENT_DIR}/configs/hypr/.config/hypr ~/.config
cp -rf ${CURRENT_DIR}/configs/hypr/.config/waybar ~/.config
cp -rf ${CURRENT_DIR}/configs/hypr/.config/wofi ~/.config

flatpak update;
sudo mkinitcpio -P;
sudo update-grub;
