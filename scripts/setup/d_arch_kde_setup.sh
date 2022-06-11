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
  plasma ark dolphin dolphin-plugins konsole okular \
  kate gwenview elisa spectacle okteta \
  firefox firefox-i18n-ru firefox-ublock-origin \
  pavucontrol-qt qpwgraph networkmanager-openvpn openssh;

cp -rf ${CURRENT_DIR}/configs/universal/.config/neofetch ~/.config;

flatpak update;
# flatpak install flathub com.mattjakeman.ExtensionManager;
# flatpak install flathub com.discordapp.Discord;
# flatpak install flathub org.telegram.desktop;
# flatpak install flathub org.octave.Octave;

sudo mkinitcpio -P; sudo update-grub;
sudo systemctl enable sddm;
