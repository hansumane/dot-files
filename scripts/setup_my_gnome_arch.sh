#!/bin/bash
set -e;

mkdir -p ~/Downloads; cd ~/Downloads;
git clone --depth=1 --recusrsive https://aur.archlinux.org/yay.git;
cd ~/Downloads/yay; makepkg -sic;
cd; rm -rf ~/Downloads/yay;

sudo pacman -Syy --needed \
  wireplumber pipewire pipewire-alsa pipewire-pulse;

sudo pacman -S --needed \
  xorg xorg-xwayland wayland;

sudo pacman -S --needed \
  noto-fonts noto-fonts-cjk noto-fonts-emoji;

sudo pacman -S --needed \
  mesa nvidia-open-dkms;

sudo pacman -S --needed \
  gnome gnome-tweaks gnome-themes-extra \
  firefox firefox-i18n-ru firefox-ublock-origin \
  kitty pavucontrol helvum networkmanager-openvpn openssh;

yay -S --needed \
  hunspell hunspell-en_us hunspell-ru \
  hyphen hyphen-en hyphen-ru \
  libreoffice-still-ru;

cp -rf ~/dot-files/configs/universal/.config/kitty ~/.config;
cp -rf ~/dot-files/configs/universal/.config/neofetch ~/.config;
sudo cp -rf ~/dot-files/themes/icon_themes/Twilight-cursors /usr/share/icons;

flatpak update;

# /etc/default/grub : 
  # "nvidia nvidia_modeset nvidia_uvm nvidia_drm nvidia-drm.modeset=1"
# /usr/lib/udev/rules.d/61-gdm.rules :
  # RUN+="/usr/lib/gdm-runtime-config set daemon PreferredDisplayServer xorg"
  # RUN+="/usr/lib/gdm-runtime-config set daemon WaylandEnable false"
