#!/bin/bash
set -e

echo "[main]
gpgcheck=True
installonly_limit=3
clean_requirements_on_remove=True
best=False
skip_if_unavailable=True
max_parallel_downloads=10
defaultyes=True" | sudo tee /etc/dnf/dnf.conf

sudo dnf autoremove -y
sudo dnf clean all -y
sudo dnf update -y

sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update -y

sudo dnf install -y \
  gstreamer1-plugins-{bad-\*,good-\*,base} \
  gstreamer1-plugin-openh264 gstreamer1-libav \
  --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional --allowerasing Multimedia
sudo dnf update -y

sudo dnf install -y \
  curl wget git zip unzip tar gzip bzip2 xz \
  nano tmux neovim zsh eza bat hexyl calc croc \
  nodejs npm yarnpkg python3-pip wireguard-tools \
  java-21-openjdk-devel python3-devel gnome-tweaks \
  rsms-inter-fonts papirus-icon-theme \
  make automake kernel-devel \
  gcc gcc-c++ \
  clang clang-devel \
  glibc-devel.x86_64 \
  libstdc++-devel.x86_64 \
  glibc-static.x86_64 \
  libstdc++-static.x86_64

sudo dnf remove PackageKit-command-not-found -y
sudo dnf autoremove -y
sudo dnf clean all -y
sudo dnf update -y

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 32
gsettings set org.gnome.desktop.peripherals.keyboard delay 225
