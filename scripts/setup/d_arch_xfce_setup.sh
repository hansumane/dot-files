#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d"/" -f3 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d"/" -f2 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d"/" -f1 | rev) = 'setup' ]; then
  echo "please go to ?/dot-files/scripts/setup folder and run script from there!";
  return 1;
else
  cd ../..; CURRENT_DIR=$(pwd);
fi;

sudo pacman -Syy --needed \
  gtk2 gtk3 gtk4 gtk-engine-murrine \
  lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
  xfce4 xfce4-goodies gnome-themes-extra kitty \
  chromium pavucontrol helvum networkmanager-openvpn openssh \
  libayatana-appindicator libappindicator-gtk3 libappindicator-gtk2 \
  nm-connection-editor network-manager-applet \
  flatpak xdg-desktop-portal-gtk;
  # firefox firefox-i18n-ru firefox-ublock-origin

yay -S --needed \
  qogir-gtk-theme papirus-icon-theme;


cp -rf ${CURRENT_DIR}/configs/universal/.config/kitty ~/.config;
cp -rf ${CURRENT_DIR}/configs/universal/.config/neofetch ~/.config;
sudo cp -rf ${CURRENT_DIR}/themes/icon_themes/Twilight-cursors /usr/share/icons;
sudo chown root:root -R /usr/share/icons/Twilight-cursors;

# flatpak update;
sudo mkinitcpio -P; sudo update-grub;
sudo systemctl enable lightdm;
