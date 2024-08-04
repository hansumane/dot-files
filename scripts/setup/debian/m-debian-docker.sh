#!/usr/bin/env bash
set -e

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  sudo apt purge -y $pkg
done

sudo apt autoremove -y
sudo apt autoclean -y

sudo apt update
sudo apt install -y curl ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update
sudo apt install \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
