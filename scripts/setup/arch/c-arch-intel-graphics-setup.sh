#!/usr/bin/env bash

set -e

sudo pacman -Sy --needed \
  intel-ucode xf86-video-intel vulkan-intel \
  vulkan-icd-loader libva-mesa-driver mesa-vdpau
