#!/usr/bin/sh

# this script is used to patch
# all Victor Mono TTF fonts with
# nerd fonts patcher
# ! it also requires:
# * https://github.com/ryanoasis/nerd-fonts.git
# * fontforge package

FONTNAME="VictorMono"
EXTENSION="ttf"

for FONT in ~/Downloads/$(FONTNAME)/*.$(EXTENSION);
do
    ~/Downloads/nerd-fonts/font-patcher \
    $FONT --complete --progressbars --outputdir \
    ~/Downloads/$(FONTNAME)Patched;
done;
