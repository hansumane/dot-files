#!/bin/bash

set -e

NYELLOW=$'\e[0;33m'
BYELLOW=$'\e[1;33m'
BRED=$'\e[1;31m'
BBLUE=$'\e[1;34m'
BCYAN=$'\e[1;94m'
BGREEN=$'\e[1;32m'
NRST=$'\e[0;0m'

PIP_PACKAGES="pynvim pylint jedi"
SU_PIP_PACKAGES=""
PIP_FLAGS="-U"

case $OSTYPE in

  *linux-gnu*)

    source /etc/os-release

    case $NAME in

      *Debian* | *Ubuntu*)
        echo "${NYELLOW}Running ${BRED}Debian-based${NYELLOW} update...${NRST}"
        sudo apt update && sudo apt full-upgrade -y &&
        sudo apt autoremove -y && sudo apt autoclean -y
        PIP_FLAGS="--break-system-packages $PIP_FLAGS"
        ;;

      *Fedora*)
        echo "${NYELLOW}Running ${BBLUE}Fedora${NYELLOW} update...${NRST}"
        sudo dnf upgrade -y --refresh && sudo dnf autoremove -y
        ;;

      *Arch*)
        echo "${NYELLOW}Running ${BCYAN}Arch${NYELLOW} update...${NRST}"
        sudo timedatectl set-ntp true && sleep 5 && sudo hwclock --systohc
        yay -Syyu
        sudo mkinitcpio -P && sudo update-grub
        yay -Scca --noconfirm
        yay -Sc --repo --noconfirm
        ;;

    esac

    ;;

  *linux-android*)

    echo "${NYELLOW}Running ${BGREEN}Android (Termux)${NYELLOW} update...${NRST}"
    pkg upgrade -y && apt update && apt full-upgrade -y
    pkg autoclean -y && apt autoremove -y && apt autoclean -y

    ;;

  *)

    echo "${NYELLOW}Your system(${BRED}${OSTYPE}${NYELLOW}) is not supported.${NRST}"
    exit 1;

    ;;

esac

echo "${NYELLOW}Running universal updates...${NRST}"

if command -v flatpak &> /dev/null; then
  echo "${NYELLOW}Running ${BBLUE}FlatPak${NYELLOW} update...${NRST}"
  flatpak update -y && sleep 1 && flatpak update -y
  flatpak uninstall --unused
fi

if command -v snap &> /dev/null; then
  echo "${NYELLOW}Running ${BRED}Snap${NYELLOW} update...${NRST}"
  sudo snap refresh && sleep 1 && sudo snap refresh
fi

[[ ! -z $PIP_PACKAGES ]] && pip3 install $PIP_PACKAGES $PIP_FLAGS ||
echo "${NYELLOW}Skipping user ${BYELLOW}Python${NYELLOW} updates...${NRST}"

case $OSTYPE in
  *linux-gnu*)
    [[ ! -z $SU_PIP_PACKAGES ]] && sudo pip3 install $SU_PIP_PACKAGES $PIP_FLAGS ||
    echo "${NYELLOW}Skipping root ${BYELLOW}Python${NYELLOW} updates..${NRST}"
    ;;
esac

zsh -c '. ~/.zshrc; omz update'
nvim +PlugUpgrade
