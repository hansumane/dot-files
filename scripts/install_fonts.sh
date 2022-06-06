#!/bin/bash
set -e;

if [ ! $(pwd | rev | cut -d"/" -f2 | rev) = 'dot-files' ] ||
    [ ! $(pwd | rev | cut -d"/" -f1 | rev) = 'scripts' ]; then
  echo "please go to ?/dot-files/scripts folder";
  exit;
fi;

if [ ! -d $(pwd)/../.fonts ]; then
  echo "no .fonts directory!";
  echo "(you have probably deleted or moved it!)";
  exit;
fi;

echo "you'll need to grant root access to copy";
echo "fonts to /usr/share/fonts/ManuallyInstalled";

cd $(pwd)/../.fonts;
sudo mkdir -p /usr/share/fonts/ManuallyInstalled;
sudo cp -rf HackAll /usr/share/fonts/ManuallyInstalled;
sudo cp -rf JetBrainsMonoAll /usr/share/fonts/ManuallyInstalled;
sudo cp -rf CascadiaCodeAll /usr/share/fonts/ManuallyInstalled;
fc-cache -r;
