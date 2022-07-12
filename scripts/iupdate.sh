#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'scripts' ]; then
  echo "please go to ?/dot-files/scripts folder and run script from there!";
  exit 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
fi;

echo "> /fonts <";
if [ ! -d ${CURRENT_DIR}/fonts ]; then
  git clone https://github.com/hansumane/fonts.git;
else
  cd ${CURRENT_DIR}/fonts;
  git pull --rebase;
fi;

echo "> /wallpapers <";
if [ ! -d ${CURRENT_DIR}/wallpapers ]; then
  git clone https://github.com/hansumane/wallpapers.git;
else
  cd ${CURRENT_DIR}/wallpapers;
  git pull --rebase;
fi;
