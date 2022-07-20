#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d'/' -f3 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d'/' -f2 | rev) = 'scripts' ] ||
    [ ! $(pwd | rev | cut -d'/' -f1 | rev) = 'setup' ]; then
  echo "please go to /scripts/setup folder and run script from there!";
  exit 1;
fi;

echo "you'll need to grant root access to copy fonts to /usr/share/fonts/ManuallyInstalled";

cd $(git rev-parse --show-toplevel)/fonts;
sudo rm -rf /usr/share/fonts/ManuallyInstalled;
sudo mkdir -p /usr/share/fonts/ManuallyInstalled;
  sudo tar -xf CascadiaCodeAll.txz -C /usr/share/fonts/ManuallyInstalled;
  sudo tar -xf FiraCodeAll.txz -C /usr/share/fonts/ManuallyInstalled;
  sudo tar -xf HackAll.txz -C /usr/share/fonts/ManuallyInstalled;
  # sudo tar -xf IosevkaAll.txz -C /usr/share/fonts/ManuallyInstalled;
  sudo tar -xf IosevkaTermAll.txz -C /usr/share/fonts/ManuallyInstalled;
  sudo tar -xf JetBrainsMonoAll.txz -C /usr/share/fonts/ManuallyInstalled;
  sudo tar -xf VictorMonoAll.txz -C /usr/share/fonts/ManuallyInstalled;
sudo chown root:root -R /usr/share/fonts/ManuallyInstalled;
fc-cache -r;
