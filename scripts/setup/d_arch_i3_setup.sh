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
  i3-gaps i3lock i3blocks rofi kitty xcompmgr feh sxiv \
  xfce4-clipman-plugin xfce4-screenshooter lxappearance pavucontrol \
  network-manager-applet networkmanager-openvpn \
  gnome-themes-extra xdg-desktop-portal-gtk xdg-user-dirs \
  flatpak firefox firefox-i18n-ru firefox-ublock-origin \
  zathura zathura-pdf-mupdf zathura-djvu helvum;

cp -f   ${CURRENT_DIR}/configs/i3/.xinitrc ~;
cp -rf  ${CURRENT_DIR}/configs/i3/.config/i3 ~/.config;
cp -rf  ${CURRENT_DIR}/configs/i3/.config/i3blocks ~/.config;
cp -rf  ${CURRENT_DIR}/configs/i3/.config/rofi ~/.config;
cp -f   ${CURRENT_DIR}/configs/universal/.Xdefaults ~;
cp -rf  ${CURRENT_DIR}/configs/universal/.config/kitty ~/.config;
cp -rf  ${CURRENT_DIR}/configs/universal/.config/neofetch ~/.config;

sudo mkdir -p  /etc/X11/xorg.conf.d;
sudo cp -f     ${CURRENT_DIR}/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d;
sudo cp -rf    ${CURRENT_DIR}/themes/gtk_themes/Everforest_Dark /usr/share/themes;
sudo cp -rf    ${CURRENT_DIR}/themes/icon_themes/Zafiro-Icons-Dark /usr/share/icons;
sudo cp -rf    ${CURRENT_DIR}/themes/icon_themes/Simp1e-Gruvbox-* /usr/share/icons;

cd ~/Downloads;
git clone --depth=1 --recursive https://github.com/nonpop/xkblayout-state.git;
cd ~/Downloads/xkblayout-state;
sudo make install;

flatpak update;
# flatpak install flathub com.mattjakeman.ExtensionManager;
# flatpak install flathub com.discordapp.Discord;
# flatpak install flathub org.telegram.desktop;
# flatpak install flathub org.octave.Octave;
