#!/bin/bash
set -e;

sudo pacman -S --needed \
  xf86-video-vmware xf86-input-vmmouse \
  virtualbox-guest-utils;
