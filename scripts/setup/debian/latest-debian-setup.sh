#!/usr/bin/env bash

set -e

sudo apt update &&
sudo apt full-upgrade -y &&
sudo apt install -y \
  curl git zip unzip tar gzip bzip2 xz-utils \
  zsh tmux calc subversion \
  clang clangd build-essential python3-pip \
  man-db manpages nodejs yarnpkg

# # curl -fL https://deb.nodesource.com/setup_18.x -o ~/setup_node.sh &&
# # chmod +x ~/setup_node.sh && sudo ~/setup_node.sh && rm -f ~/setup_node.sh
# # curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg > /dev/null &&
# # echo 'deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main' | sudo tee /etc/apt/sources.list.d/yarn.list
#
# # sudo apt update &&
# # sudo apt install -y nodejs yarn
# # sudo apt autoremove -y &&
# # sudo apt autoclean -y

# if (lscpu | grep Intel &> /dev/null); then
#   sudo apt install intel-microcode iucode-tool -y;
# elif (lscpu | grep AMD &> /dev/null); then
#   sudo apt install amd64-microcode -y;
# else
#   echo "your CPU is neither Intel nor AMD";
# fi;

echo 'LC_COLLATE="C"' | sudo tee -a /etc/default/locale
