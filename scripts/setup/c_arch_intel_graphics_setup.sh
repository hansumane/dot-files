#!/bin/bash
set -e;

sudo pacman -S --needed \
  xf86-video-intel vulkan-intel vulkan-icd-loader \
  libva-mesa-driver mesa-vdpau;
