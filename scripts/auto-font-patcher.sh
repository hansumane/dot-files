#!/usr/bin/env bash
set -xe

FONTNAME="CascadiaCodePL"
EXTENSION=".otf"
DIRNAME="$(pwd)"

if [[ ! -d "${DIRNAME}/nerd-fonts" ]]; then
  mkdir -p "${DIRNAME}/nerd-fonts"
  cd "${DIRNAME}/nerd-fonts"
  git clone --recursive --depth=1 \
    https://github.com/ryanoasis/nerd-fonts.git \
    "${DIRNAME}/nerd-fonts"
else
  cd "${DIRNAME}/nerd-fonts"
  git reset --hard HEAD
  git pull --rebase
fi

$EDITOR "${DIRNAME}/nerd-fonts/font-patcher"

if [[ ! -d "${DIRNAME}/${FONTNAME}All" ]]; then
  echo "No such font directory: ${FONTNAME}All/"; exit 1
else
  mkdir -p "${DIRNAME}/${FONTNAME}All/${FONTNAME}Patched"
fi

for FONT in "${DIRNAME}/${FONTNAME}All/*${EXTENSION}"; do
  "${DIRNAME}/nerd-fonts/font-patcher" \
  "${FONT}" --careful --complete --progressbars --outputdir \
  "${DIRNAME}/${FONTNAME}All/${FONTNAME}Patched"
done
