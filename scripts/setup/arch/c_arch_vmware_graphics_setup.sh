#!/bin/bash
set -e
sudo pacman -Sy --needed \
  xf86-video-vmware xf86-input-vmmouse \
  virtualbox-guest-utils
