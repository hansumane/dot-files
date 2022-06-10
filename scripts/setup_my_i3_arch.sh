#!/bin/bash
set -e;

sudo pacman -Syy --needed \
  curl git zip unzip neovim zsh exa bat hexyl tmux calc;

sudo pacman -S --needed \
  wireplumber pipewire pipewire-alsa pipewire-pulse pipewire-jack;

sudo pacman -S --needed \
  xorg xorg-xinit xorg-xwayland wayland;

sudo pacman -S --needed \
  noto-fonts noto-fonts-cjk noto-fonts-emoji;

sudo pacman -S --needed \
  mesa nvidia-dkms;

sudo pacman -S --needed \
  i3-gaps i3lock i3blocks rofi kitty xcompmgr feh sxiv \
  xfce4-clipman-plugin xfce4-screenshooter lxappearance pavucontrol \
  network-manager-applet networkmanager-openvpn \
  gnome-themes-extra xdg-desktop-portal-gtk xdg-user-dirs \
  flatpak firefox firefox-i18n-ru firefox-ublock-origin \
  zathura zathura-pdf-mupdf zathura-djvu helvum;

mkdir -p ~/Downloads; cd ~/Downloads;
git clone --depth=1 https://aur.archlinux.org/yay.git;
cd ~/Downloads/yay; makepkg -sic;
cd; rm -rf ~/Downloads/yay;

yay -S --needed \
  hunspell hunspell-en_us hunspell-ru \
  hyphen hyphen-en hyphen-ru \
  libreoffice-still-ru \
  visual-studio-code-bin;

cp -f   ~/dot-files/configs/i3/.xinitrc ~;
cp -rf  ~/dot-files/configs/i3/.config/i3 ~/.config;
cp -rf  ~/dot-files/configs/i3/.config/i3blocks ~/.config;
cp -rf  ~/dot-files/configs/i3/.config/rofi ~/.config;
cp -f   ~/dot-files/configs/universal/.Xdefaults ~;
cp -rf  ~/dot-files/configs/universal/.config/kitty ~/.config;
cp -rf  ~/dot-files/configs/universal/.config/neofetch ~/.config;

sudo mkdir -p  /etc/X11/xorg.conf.d;
sudo cp -f     ~/dot-files/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d;
sudo cp -rf    ~/dot-files/themes/gtk_themes/Everforest_Dark /usr/share/themes;
sudo cp -rf    ~/dot-files/themes/icon_themes/Zafiro-Icons-Dark /usr/share/icons;
sudo cp -rf    ~/dot-files/themes/icon_themes/Simp1e-Gruvbox-* /usr/share/icons;

cd ~/Downloads;
git clone --depth=1 --recursive https://github.com/nonpop/xkblayout-state.git;
cd ~/Downloads/xkblayout-state;
sudo make install;

flatpak update;
