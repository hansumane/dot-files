#!/usr/bin/sh

# this script is used to patch
# all Victor Mono TTF fonts with
# nerd fonts patcher
# ! it also requires:
# * https://github.com/ryanoasis/nerd-fonts.git
# * fontforge package

FONTNAME="VictorMono"
EXTENSION="ttf"

for FONT in /home/$(whoami)/Downloads/$(FONTNAME)/*.$(EXTENSION);
do
    /home/$(whoami)/Downloads/nerd-fonts/font-patcher \
    $FONT --mono --complete --progressbars --outputdir \
    /home/$(whoami)/Downloads/$(FONTNAME)Patched;
done;
