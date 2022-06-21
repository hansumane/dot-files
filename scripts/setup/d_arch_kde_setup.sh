#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d"/" -f3 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d"/" -f2 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d"/" -f1 | rev) = 'setup' ]; then
  echo "please go to ?/dot-files/scripts/setup folder and run script from there!";
  exit;
else
  cd ../..;
  CURRENT_DIR=$(pwd);
fi;

sudo pacman -S --needed --noconfirm \
  plasma ark dolphin dolphin-plugins konsole okular \
  kate gwenview elisa spectacle okteta \
  chromium flatpak xdg-desktop-portal-kde openssh \
  pavucontrol-qt qpwgraph networkmanager-openvpn;
  # firefox firefox-i18n-ru firefox-ublock-origin

cp -rf ${CURRENT_DIR}/configs/universal/.config/neofetch ~/.config;

flatpak update;
sudo mkinitcpio -P; sudo update-grub;
sudo systemctl enable sddm;

sudo sed 's/Exec=.*/# Exec=\/usr\/bin\/kwalletd5/g' -i /usr/share/dbus-1/services/org.kde.kwalletd5.service;
