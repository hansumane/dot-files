#!/bin/bash
set -e
sudo pacman -Sy --needed \
  xf86-video-amdgpu xf86-video-ati \
  vulkan-radeon libva-mesa-driver mesa-vdpau
