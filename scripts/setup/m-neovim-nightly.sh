#!/usr/bin/env bash
set -e
cd

if [[ $# -ne 0 ]]; then
  echo "Usage: NVIM_DESTDIR='' NVIM_PREFIX='/usr/local' ./m-neovim-nightly.sh"
  exit 1
fi

TEMPDIR="$HOME/.itemp"
if [[ -d "$TEMPDIR" ]]; then
  rm -rvf "$TEMPDIR"
fi
mkdir -vp "$TEMPDIR"
cd "$TEMPDIR"

case $OSTYPE in
  *linux-gnu*)
    NVIM_FN="nvim-linux64"
    ;;
  *darwin*)
    NVIM_FN="nvim-macos"
    ;;
  *)
    echo "ERROR: Your system ($OSTYPE) is not supported"
    exit 1
    ;;
esac

if [[ -z "$NVIM_DESTDIR" ]]; then NVIM_DESTDIR=""; fi
if [[ -z "$NVIM_PREFIX" ]]; then NVIM_PREFIX="/usr/local"; fi

# neovim nightly (vim > vi replacement)
curl -fLO "https://github.com/neovim/neovim/releases/download/nightly/$NVIM_FN.tar.gz"
tar xvf "$NVIM_FN.tar.gz"
sudo mkdir -vp "${NVIM_DESTDIR}${NVIM_PREFIX}"
sudo mkdir -vp "${NVIM_DESTDIR}${NVIM_PREFIX}/share"
sudo cp -vrf "$NVIM_FN/bin" "${NVIM_DESTDIR}${NVIM_PREFIX}"
sudo cp -vrf "$NVIM_FN/share/applications" "${NVIM_DESTDIR}${NVIM_PREFIX}/share"
sudo cp -vrf "$NVIM_FN/share/icons" "${NVIM_DESTDIR}${NVIM_PREFIX}/share"
sudo cp -vrf "$NVIM_FN/share/locale" "${NVIM_DESTDIR}${NVIM_PREFIX}/share"
sudo cp -vrf "$NVIM_FN/share/nvim" "${NVIM_DESTDIR}${NVIM_PREFIX}/share"
if [[ -L "${NVIM_DESTDIR}${NVIM_PREFIX}/share/man" ]]; then
  sudo cp -vrf "$NVIM_FN/share/man"/* "${NVIM_DESTDIR}${NVIM_PREFIX}/share/man"
else
  sudo cp -vrf "$NVIM_FN/share/man" "${NVIM_DESTDIR}${NVIM_PREFIX}/share"
fi

cd
rm -rvf "$TEMPDIR"
