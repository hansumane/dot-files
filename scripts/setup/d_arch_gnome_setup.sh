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

sudo pacman -Syy --needed --noconfirm \
  gnome gnome-tweaks gnome-themes-extra \
  flatpak xdg-desktop-portal-gnome chromium \
  pavucontrol helvum networkmanager-openvpn openssh \
  libayatana-appindicator libappindicator-gtk3 libappindicator-gtk2;
  # firefox firefox-i18n-ru firefox-ublock-origin

cp -rf ${CURRENT_DIR}/configs/universal/.config/neofetch ~/.config;
sudo cp -rf ${CURRENT_DIR}/themes/icon_themes/Twilight-cursors /usr/share/icons;
sudo chown root:root -R /usr/share/icons/Twilight-cursors;

flatpak update;
sudo mkinitcpio -P; sudo update-grub;
sudo systemctl enable gdm;

sudo sed 's/RUN+="\/usr\/lib\/gdm-runtime-config set daemon PreferredDisplayServer xorg"/# RUN+="\/usr\/lib\/gdm-runtime-config set daemon PreferredDisplayServer xorg"/g' -i /usr/lib/udev/rules.d/61-gdm.rules;
sudo sed 's/RUN+="\/usr\/lib\/gdm-runtime-config set daemon WaylandEnable false"/# RUN+="\/usr\/lib\/gdm-runtime-config set daemon WaylandEnable false"/g' -i /usr/lib/udev/rules.d/61-gdm.rules;
