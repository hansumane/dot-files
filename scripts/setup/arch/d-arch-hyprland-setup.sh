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

# NVIDIA ONLY: change hyprland to hyprland-nvidia-git and add libva
yay -Sy --needed hyprland \
  gtk-engine-murrine gtk2 gtk3 gtk4 qt5ct qt6ct qt5-wayland qt6-wayland \
  hyprshot hyprpaper wlogout swaylock-effects wofi waybar swayidle \
  dunst nwg-look-bin lxappearance gnome-themes-extra kvantum grim slurp \
  pavucontrol sddm dolphin dolphin-plugins kitty alacritty xwaylandvideobridge-bin \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal xdg-user-dirs \
  nm-connection-editor network-manager-applet networkmanager-openvpn \
  flatpak helvum eog zathura zathura-pdf-mupdf zathura-djvu \
  libayatana-appindicator libappindicator-gtk2 libappindicator-gtk3 \
  inter-font firefox firefox-i18n-ru

cp -rf ${CURRENT_DIR}/configs/hypr/.config/* ~/.config
cp -rf ${CURRENT_DIR}/configs/universal/.config/kitty ~/.config
cp -rf ${CURRENT_DIR}/configs/universal/.config/alacritty ~/.config

flatpak update
set +e
sudo mkinitcpio -P
set -e
sudo update-grub
sudo systemctl enable sddm
