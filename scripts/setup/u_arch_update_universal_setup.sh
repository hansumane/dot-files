#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'setup' ]; then
  echo "please go to ?/dot-files/scripts/setup folder and run script from there!";
  return 1;
else
  cd $(git rev-parse --show-toplevel); CURRENT_DIR=$(pwd);
fi;

cp -f ${CURRENT_DIR}/configs/universal/.zshrc ~;
sed 's/EXA_ICONS="--no-icons"/EXA_ICONS="--icons"/g' -i ~/.zshrc;
cp -rf ${CURRENT_DIR}/configs/universal/.config/nvim ~/.config;

if [ ! -f /usr/bin/system-update ]; then
  sudo cp -f ${CURRENT_DIR}/scripts/system-update-arch /usr/bin/system-update;
  sudo chown root:root /usr/bin/system-update;
  sudo chmod 755 /usr/bin/system-update;
fi;

nvim;
