#!/bin/bash
set -e;

sudo pacman -S --needed i3-gaps i3lock i3blocks rofi \
  kitty xcompmgr feh xfce4-clipman-plugin xfce4-screenshooter \
  network-manager-applet lxappearance pavucontrol \
  gnome-themes-extra papirus-icon-theme \
  firefox firefox-i18n-ru firefox-ublock-origin;

sudo cp -f  ~/dot-files/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xord.conf.d;
cp -f       ~/dot-files/configs/i3/.xinitrc ~;
cp -rf      ~/dot-files/configs/i3/.config/i3 ~/.config;
cp -rf      ~/dot-files/configs/i3/.config/i3blocks ~/.config;
cp -rf      ~/dot-files/configs/i3/.config/rofi ~/.config;
cp -rf      ~/dot-files/configs/universal/.config/kitty ~/.config;
cp -rf      ~/dot-files/configs/universal/.config/neofetch ~/.config;

mkdir -p ~/Downloads;
cd ~/Downloads;
git clone --depth=1 --recursive https://aur.archlinux.org/yay.git;
cd ~/Downloads/yay;
rm -rf .git*;
makepkg -sic;

cd ~/Downloads;
git clone --depth=1 --recursive https://github.com/nonpop/xkblayout-state.git;
cd ~/Downloads/xkblayout-state;
sudo make install;
