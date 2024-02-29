#!/usr/bin/env bash
set -xe

mkdir -vp ./.temp-files
cd ./.temp-files

SCRIPTS_PREFIX="https://raw.githubusercontent.com/torvalds/linux/master/scripts"
curl -fLO "$SCRIPTS_PREFIX/checkpatch.pl"
curl -fLO "$SCRIPTS_PREFIX/const_structs.checkpatch"
curl -fLO "$SCRIPTS_PREFIX/spelling.txt"

sudo install -v ./checkpatch.pl /usr/local/bin
sudo cp -v ./const_structs.checkpatch /usr/local/bin
sudo cp -v ./spelling.txt /usr/local/bin

cd -
rm -rfv ./.temp-files
