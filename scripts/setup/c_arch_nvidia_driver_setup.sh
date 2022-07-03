#!/bin/bash
set -e;

sudo pacman -S --needed --noconfirm \
  mesa nvidia-open-dkms;

sudo sed 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash loglevel=3 nvidia nvidia_modeset nvidia_uvm nvidia_drm nvidia-drm.modeset=1"/g' -i /etc/default/grub;

sudo update-grub;
