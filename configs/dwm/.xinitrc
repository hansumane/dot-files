#!/bin/sh
~/.fehbg &
slstatus &
xset r rate 250 30
xcompmgr -r 0 -o 0 -l 0 -t 0 -I 0.0625 -O 0.0625 -c -f &
exec dwm
