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

sudo pacman -Syy --needed \
  gnome gnome-tweaks gnome-themes-extra \
  # firefox firefox-i18n-ru firefox-ublock-origin \
  chromium \
  pavucontrol helvum networkmanager-openvpn openssh;

cp -rf ${CURRENT_DIR}/configs/universal/.config/neofetch ~/.config;
sudo cp -rf ${CURRENT_DIR}/themes/icon_themes/Twilight-cursors /usr/share/icons;
sudo chown root:root -R /usr/share/icons/Twilight-cursors;

flatpak update;
# flatpak install flathub com.mattjakeman.ExtensionManager;
# flatpak install flathub com.discordapp.Discord;
# flatpak install flathub org.telegram.desktop;
# flatpak install flathub org.octave.Octave;

sudo mkinitcpio -P; sudo update-grub;
sudo systemctl enable gdm;
