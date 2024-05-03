#!/usr/bin/env bash
set -e

NYELLOW=$'\e[0;33m'
BYELLOW=$'\e[1;33m'
BRED=$'\e[1;31m'
BGREEN=$'\e[1;32m'
BBLUE=$'\e[1;34m'
BCYAN=$'\e[1;94m'
BMAGENTA=$'\e[1;35m'
BWHITE=$'\e[1;37m'
NRST=$'\e[0m'

# pynvim pylint jedi 'python-lsp-server[all]'
PIP_PACKAGES=""
SU_PIP_PACKAGES=""
PIP_FLAGS="-U"

clear
echo "${NYELLOW}You may need to enter your ${BRED}sudo${NYELLOW} password.${NRST}"

case $OSTYPE in

  *linux-gnu*)

    source /etc/os-release

    case $NAME in

      *Debian* | *Ubuntu*)
        echo "${NYELLOW}Running ${BRED}Debian-based${NYELLOW} updates.${NRST}"
        PIP_FLAGS="--break-system-packages $PIP_FLAGS"
        sudo apt update && sudo apt full-upgrade -y &&
        sudo apt autoremove -y && sudo apt autoclean -y
        ;;

      *Fedora*)
        echo "${NYELLOW}Running ${BBLUE}Fedora${NYELLOW} updates.${NRST}"
        sudo dnf upgrade -y --refresh && sudo dnf autoremove -y
        ;;

      *Arch*)
        echo "${NYELLOW}Running ${BCYAN}Arch${NYELLOW} updates.${NRST}"
        PIP_FLAGS="--break-system-packages $PIP_FLAGS"
        sudo timedatectl set-ntp true && sleep 10 && sudo hwclock --systohc
        yay -Syyu
        sudo mkinitcpio -P && sudo chmod 600 /boot/initramfs-linux* && sudo update-grub
        yay -Scca --noconfirm
        yay -Sc --repo --noconfirm
        ;;

      *"openSUSE Tumbleweed"*)
        echo "${NYELLOW}Running ${BGREEN}OpenSUSE Tumbleweed${NYELLOW} updates.${NRST}"
        PIP_FLAGS="--break-system-packages $PIP_FLAGS"
        sudo systemctl stop packagekit
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

  *darwin*)

  echo "${NYELLOW}Running ${BWHITE}MacOS${NYELLOW} updates.${NRST}"
  brew update && brew upgrade

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
  set +e; flatpak uninstall --unused; set -e
fi

if command -v snap &> /dev/null; then
  echo "${NYELLOW}Running ${BRED}Snap${NYELLOW} updates.${NRST}"
  sudo snap refresh && sleep 1 && sudo snap refresh
fi

[[ ! -z $PIP_PACKAGES ]] && bash -c "pip3 install $PIP_PACKAGES $PIP_FLAGS" ||
echo "${NYELLOW}Skipping user ${BBLUE}Python${NYELLOW} updates.${NRST}"

case $OSTYPE in
  *linux-gnu*|*darwin*)
    [[ ! -z $SU_PIP_PACKAGES ]] && sudo bash -c "pip3 install $PIP_PACKAGES $PIP_FLAGS" ||
    echo "${NYELLOW}Skipping root ${BBLUE}Python${NYELLOW} updates.${NRST}"
    ;;
esac

if command -v zsh &> /dev/null; then
  if [[ -d $HOME/.oh-my-zsh ]]; then
    echo "${NYELLOW}Running ${BGREEN}oh-my-zsh${NYELLOW} update.${NRST}"

    for PLUGIN_PATH in $HOME/.oh-my-zsh/custom/plugins/zsh-*; do
      PLUGIN_NAME="$(basename "$PLUGIN_PATH")"

      echo "${NYELLOW}Running ${BGREEN}oh-my-zsh${NYELLOW}:${BWHITE}${PLUGIN_NAME}${NYELLOW} plugin update.${NRST}"

      cd "$PLUGIN_PATH"
      git reset --hard HEAD &> /dev/null
      git fetch --all &> /dev/null
      git pull --rebase
      cd - &> /dev/null
    done

    zsh -c '. ~/.zshrc; omz update'
  fi
fi

if command -v rustup &> /dev/null; then
  echo "${NYELLOW}Running ${BRED}Rust${NYELLOW} update.${NRST}"
  rustup update
fi

if command -v doom &> /dev/null; then
  echo "${NYELLOW}Running ${BMAGENTA}DOOM Emacs${NYELLOW} update.${NRST}"

  cd "$(dirname $(which doom))"
  git reset --hard HEAD &> /dev/null
  git fetch --all &> /dev/null
  git pull --rebase

  cd - &> /dev/null
  doom sync -u --jobs $(nproc) && doom doctor | cat && doom sync -U --jobs $(nproc)
fi

if command -v nvim &> /dev/null; then
  echo "${NYELLOW}Don't forget to do ${BBLUE}Neo${BGREEN}VIM${NYELLOW} update.${NRST}"
fi
