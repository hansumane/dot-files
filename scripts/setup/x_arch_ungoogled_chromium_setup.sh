#!/bin/bash
set -e;

curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Arch/x86_64/home_ungoogled_chromium_Arch.key' | sudo pacman-key -a -;
echo '
[home_ungoogled_chromium_Arch]
SigLevel = Required TrustAll
Server = https://download.opensuse.org/repositories/home:/ungoogled_chromium/Arch/$arch' | sudo tee --append /etc/pacman.conf;
sudo pacman -Syy --needed --noconfirm ungoogled-chromium;
