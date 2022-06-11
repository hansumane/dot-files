#!/bin/bash
set -e;

sudo pacman -S --needed \
  mesa nvidia-dkms;

# /etc/default/grub : 
  # "nvidia nvidia_modeset nvidia_uvm nvidia_drm nvidia-drm.modeset=1"
# /usr/lib/udev/rules.d/61-gdm.rules :
  # RUN+="/usr/lib/gdm-runtime-config set daemon WaylandEnable false"
