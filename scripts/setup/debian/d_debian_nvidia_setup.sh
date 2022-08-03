#!/bin/bash
set -e;

sudo apt install -y \
  nvidia-driver;

sudo sed 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia nvidia_modeset nvidia_uvm nvidia_drm nvidia-drm.modeset=1"/g' -i /etc/default/grub;

sudo update-grub;
