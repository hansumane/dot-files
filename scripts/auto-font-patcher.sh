#!/usr/bin/env bash

set -xe

FONTNAME='Iosevka'
EXTENSION='.ttf'
DIRNAME=$(pwd)

if [[ ! -d ${DIRNAME}/nerd-fonts ]]; then
  mkdir -p ${DIRNAME}/nerd-fonts
  cd ${DIRNAME}/nerd-fonts
  git clone --depth=1 --recursive https://github.com/ryanoasis/nerd-fonts.git ${DIRNAME}/nerd-fonts
else
  cd ${DIRNAME}/nerd-fonts
  git reset --hard HEAD
  git pull
fi

if [[ ! -d ${DIRNAME}/${FONTNAME}All/ ]]; then
  echo "No such font directory: ${FONTNAME}All/"; exit 1
else
  mkdir -p ${DIRNAME}/${FONTNAME}All/${FONTNAME}Patched/
fi

for FONT in ${DIRNAME}/${FONTNAME}All/*${EXTENSION}; do
  ${DIRNAME}/nerd-fonts/font-patcher \
  ${FONT} --careful --complete --progressbars --outputdir \
  ${DIRNAME}/${FONTNAME}All/${FONTNAME}Patched/
done
