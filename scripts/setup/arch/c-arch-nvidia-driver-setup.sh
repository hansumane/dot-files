#!/usr/bin/env bash
set -e

sudo pacman -Sy --needed \
  mesa nvidia-open-dkms nvidia-utils opencl-nvidia

echo "GRUB_CMDLINE_LINUX_DEFAULT='... nvidia nvidia_modeset nvidia_uvm nvidia_drm nvidia-drm.modeset=1'" | sudo tee -a /etc/default/grub
EDITOR=nvim sudoedit /etc/default/grub

sudo mkdir -p /etc/modprobe.d
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
