#!/bin/sh
~/.fehbg &
~/Downloads/dwm/sbar.sh &
xrandr --output DisplayPort-0 --primary --mode 1440x900 --rate 74.98 &
exec dwm
