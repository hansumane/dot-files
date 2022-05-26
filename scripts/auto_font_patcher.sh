#!/bin/bash
set -e;

FONTNAME="JetBrainsMono";
EXTENSION=".ttf";
DIRNAME="$(pwd)";

if [ ! -d ${DIRNAME}/nerd-fonts ]; then
    git clone --depth=1 --recursive https://github.com/ryanoasis/nerd-fonts.git;
fi;

if [ ! -d ${DIRNAME}/${FONTNAME}All ]; then
    echo "No such font directory: ${FONTNAME}All";
    exit;
else
    mkdir -p ${DIRNAME}/${FONTNAME}All/${FONTNAME}Patched;
fi;

for FONT in ${DIRNAME}/${FONTNAME}All/*${EXTENSION}; do
    ${DIRNAME}/nerd-fonts/font-patcher \
    $FONT --complete --progressbars --outputdir \
    ${DIRNAME}/${FONTNAME}All/${FONTNAME}Patched;
done;
