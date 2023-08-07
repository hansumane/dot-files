#!/bin/bash

set -e

NYELLOW=$'\e[0;33m'
BYELLOW=$'\e[1;33m'
BRED=$'\e[1;31m'
BBLUE=$'\e[1;34m'
BCYAN=$'\e[1;94m'
BGREEN=$'\e[1;32m'
NRST=$'\e[0;0m'

PIP_PACKAGES=""
SU_PIP_PACKAGES=""
PIP_FLAGS="-U"

clear
echo "${NYELLOW}You may need to enter your ${BRED}sudo password.${NRST}"

case $OSTYPE in

  *linux-gnu*)

    source /etc/os-release

    case $NAME in

      *Debian* | *Ubuntu*)
        echo "${NYELLOW}Running ${BRED}Debian-based${NYELLOW} updates.${NRST}"
        sudo apt update && sudo apt full-upgrade -y &&
        sudo apt autoremove -y && sudo apt autoclean -y
        PIP_FLAGS="--break-system-packages $PIP_FLAGS"
        ;;

      *Fedora*)
        echo "${NYELLOW}Running ${BBLUE}Fedora${NYELLOW} updates.${NRST}"
        sudo dnf upgrade -y --refresh && sudo dnf autoremove -y
        ;;

      *Arch*)
        echo "${NYELLOW}Running ${BCYAN}Arch${NYELLOW} updates.${NRST}"
        sudo timedatectl set-ntp true && sleep 5 && sudo hwclock --systohc
        yay -Syyu
        sudo mkinitcpio -P && sudo update-grub
        yay -Scca --noconfirm
        yay -Sc --repo --noconfirm
        ;;

      *openSUSE\ Tumbleweed*)
        echo "${NYELLOW}Running ${BGREEN}OpenSUSE Tumbleweed${NYELLOW} updates.${NRST}"
        sudo zypper ref && sudo zypper dup
        ;;

      *)
        echo "${NYELLOW}Your ${OSTYPE}: ${BRED}${NAME}${NYELLOW} is not supported.${NRST}"
        exit 1;
        ;;

    esac

    ;;

  *linux-android*)

    echo "${NYELLOW}Running ${BGREEN}Android (Termux)${NYELLOW} updates.${NRST}"
    pkg upgrade -y && apt update && apt full-upgrade -y
    pkg autoclean -y && apt autoremove -y && apt autoclean -y

    ;;

  *)

    echo "${NYELLOW}Your system: ${BRED}${OSTYPE}${NYELLOW} is not supported.${NRST}"
    exit 1;

    ;;

esac

echo "${NYELLOW}Running universal updates.${NRST}"

if command -v flatpak &> /dev/null; then
  echo "${NYELLOW}Running ${BBLUE}FlatPak${NYELLOW} updates.${NRST}"
  flatpak update && sleep 1 && flatpak update
  flatpak uninstall --unused
fi

if command -v snap &> /dev/null; then
  echo "${NYELLOW}Running ${BRED}Snap${NYELLOW} updates.${NRST}"
  sudo snap refresh && sleep 1 && sudo snap refresh
fi

[[ ! -z $PIP_PACKAGES ]] && pip3 install $PIP_PACKAGES $PIP_FLAGS ||
echo "${NYELLOW}Skipping user ${BBLUE}Python${NYELLOW} updates.${NRST}"

case $OSTYPE in
  *linux-gnu*)
    [[ ! -z $SU_PIP_PACKAGES ]] && sudo pip3 install $SU_PIP_PACKAGES $PIP_FLAGS ||
    echo "${NYELLOW}Skipping root ${BBLUE}Python${NYELLOW} updates.${NRST}"
    ;;
esac

if command -v zsh &> /dev/null; then
  echo "${NYELLOW}Running ${BGREEN}ZSH${NYELLOW} update.${NRST}"
  zsh -c '. ~/.zshrc; omz update'
fi

if command -v nvim &> /dev/null; then
  echo "${NYELLOW}Running ${BGREEN}NeoVIM${NYELLOW} update.${NRST}"
  nvim +PlugUpgrade
fi
