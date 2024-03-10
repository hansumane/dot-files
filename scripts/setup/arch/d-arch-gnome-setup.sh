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
  gtk-engine-murrine gtk2 gtk3 gtk4 qt5ct qt6ct qt5-wayland qt6-wayland \
  gnome gnome-tweaks gnome-themes-extra kvantum \
  flatpak xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal \
  pavucontrol helvum openssh kitty alacritty inter-font \
  nm-connection-editor network-manager-applet networkmanager-openvpn \
  libayatana-appindicator libappindicator-gtk2 libappindicator-gtk3 \
  firefox firefox-i18n-ru zathura zathura-pdf-mupdf zathura-djvu

flatpak update
set +e
sudo mkinitcpio -P
set -e
sudo update-grub
sudo systemctl enable gdm

# sudo sed 's/RUN+="\/usr\/lib\/gdm-runtime-config set daemon PreferredDisplayServer xorg"/# RUN+="\/usr\/lib\/gdm-runtime-config set daemon PreferredDisplayServer xorg"/g' -i /usr/lib/udev/rules.d/61-gdm.rules
# sudo sed 's/RUN+="\/usr\/lib\/gdm-runtime-config set daemon WaylandEnable false"/# RUN+="\/usr\/lib\/gdm-runtime-config set daemon WaylandEnable false"/g' -i /usr/lib/udev/rules.d/61-gdm.rules
