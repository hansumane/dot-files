#!/usr/bin/sh
~/.fehbg &
slstatus &
xcompmgr -r 0 -o 0 -l 0 -t 0 -I 0.0625 -O 0.0625 -c -f &
exec dwm
