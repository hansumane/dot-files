#!/bin/bash
set -e;

sudo pacman -S --needed --noconfirm \
  amd-ucode xf86-video-amdgpu xf86-video-ati \
  vulkan-radeon libva-mesa-driver mesa-vdpau;
