#!/usr/bin/env bash

set -e

if [[ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'dot-files' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'scripts' ]] ||
   [[ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'setup' ]]; then
  echo 'please go to /scripts/setup/ folder and run script from there!'; exit 1
fi

echo 'you will need to grant root access to copy fonts to /usr/share/fonts/ManuallyInstalled/'

cd $(git rev-parse --show-toplevel)/fonts/
sudo rm -rf /usr/share/fonts/ManuallyInstalled/
sudo mkdir -p /usr/share/fonts/ManuallyInstalled/
  cat IosevkaAll.tar.xz.part* > IosevkaAll.tar.xz
  sudo tar xvf JetBrainsMonoAll.tar.xz -C /usr/share/fonts/ManuallyInstalled/
  sudo tar xvf CascadiaCodeAll.tar.xz -C /usr/share/fonts/ManuallyInstalled/
  sudo tar xvf VictorMonoAll.tar.xz -C /usr/share/fonts/ManuallyInstalled/
  sudo tar xvf IosevkaAll.tar.xz -C /usr/share/fonts/ManuallyInstalled/
  rm -f IosevkaAll.tar.xz
sudo chown root:root -R /usr/share/fonts/ManuallyInstalled/
fc-cache -r
