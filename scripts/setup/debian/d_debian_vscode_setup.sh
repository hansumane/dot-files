#!/bin/bash
set -e;

curl -sSL https://packages.microsoft.com/keys/microsoft.asc -o ./microsoft.asc;
gpg --no-default-keyring --keyring ./ms_vscode_key_temp.gpg --import ./microsoft.asc;
gpg --no-default-keyring --keyring ./ms_vscode_key_temp.gpg --export > ./ms_vscode_key.gpg;
sudo cp -f ./ms_vscode_key.gpg /etc/apt/trusted.gpg.d;

sudo rm -f ./microsoft.asc* \
           ./ms_vscode_key.gpg* \
           ./ms_vscode_key_temp.gpg*;

echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list;

sudo apt update &&
sudo apt install code -y &&
sudo apt autoremove -y &&
sudo apt autoclean -y;
