#!/bin/bash
set -e;

RUNNER=$(echo $UID);

if [ ! $RUNNER = '0' ]; then
  echo "please, run this script as a root!";
  exit;
fi;

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

cd $(pwd)/../.fonts;
mkdir -p /usr/share/fonts/ManuallyInstalled;
cp -rf * /usr/share/fonts/ManuallyInstalled;
