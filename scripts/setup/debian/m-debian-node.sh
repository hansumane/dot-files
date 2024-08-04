#!/usr/bin/env bash
set -e

NODE_MAJOR=20

for pkg in nodejs yarn; do
  sudo apt purge -y $pkg
done

sudo apt update
sudo apt install -y curl gnupg ca-certificates build-essential
sudo curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
sudo curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | \
  sudo gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg

echo \
  "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] \
  https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | \
  sudo tee /etc/apt/sources.list.d/nodesource.list
echo \
  "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] \
  https://dl.yarnpkg.com/debian stable main" | \
  sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update
sudo apt install nodejs yarn
