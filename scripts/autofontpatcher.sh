#!/usr/bin/sh

for FONT in ~/Downloads/FONTNAMEAll/*.EXTENSION;
do
    ~/Downloads/nerd-fonts/font-patcher \
    $FONT --complete --progressbars --outputdir \
    ~/Downloads/FONTNAMEPatched;
done;
