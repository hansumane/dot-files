#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'scripts' ]; then
  echo "please go to /scripts folder and run script from there!";
  exit 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
fi;

echo "-> /fonts ...";
if [ ! -d ${CURRENT_DIR}/fonts ]; then
  git clone --depth=1 https://github.com/hansumane/fonts.git > /dev/null;
  git status > /dev/null;
  echo "---> /fonts cloned.";
else
  cd ${CURRENT_DIR}/fonts;
  git pull --rebase > /dev/null;
  git status > /dev/null;
  echo "---> /fonts updated.";
fi;

echo "-> /wallpapers ...";
if [ ! -d ${CURRENT_DIR}/wallpapers ]; then
  git clone --depth=1 https://github.com/hansumane/wallpapers.git > /dev/null;
  git status > /dev/null;
  echo "---> /wallpapers cloned.";
else
  cd ${CURRENT_DIR}/wallpapers;
  git pull --rebase > /dev/null;
  git status > /dev/null;
  echo "---> /wallpapers updated.";
fi;

echo "-> done!";
