#!/usr/bin/sh

# this script is used to patch
# all Victor Mono TTF fonts with
# nerd fonts patcher
# ! it also requires:
# * https://github.com/ryanoasis/nerd-fonts.git
# * fontforge package

for FONT in /home/$(whoami)/Downloads/VictorMonoAll/TTF/*.ttf;
do
    /home/$(whoami)/Downloads/nerd-fonts/font-patcher \
    $FONT --mono --complete --progressbars --outputdir \
    /home/$(whoami)/Downloads/VictorMonoPatched;
done;
