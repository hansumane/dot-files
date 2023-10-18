#!/bin/sh
# runx_gs.sh = run XDGs, this script
# is required because of a bug in
# xdg-desktop-portal-hyprland
# (already fixed in git: d8daa2a)
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
