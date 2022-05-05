#!/bin/bash

FONTNAME="JetBrainsMono"

for FONT in ~/Downloads/${FONTNAME}All/*.EXTENSION;
do
    ~/Downloads/nerd-fonts/font-patcher \
    $FONT --complete --progressbars --outputdir \
    ~/Downloads/${FONTNAME}Patched;
done;
