#!/bin/sh
set -e

THREADS=$(getconf _NPROCESSORS_ONLN)

VIM_PREFIX="/usr/local"
VIM_REPO="https://github.com/vim/vim.git"
VIM_GIT_BRANCH=$(git -c 'versionsort.suffix=-' ls-remote --tags \
                 --sort='v:refname' "$VIM_REPO" | tail -n1 \
                 | cut -d'/' -f3 | cut -d'^' -f1)
VIM_FOLDER="vim-$VIM_GIT_BRANCH"
VIM_ARCHIVE="$VIM_FOLDER.cpio.xz"

CFLAGS="-s -O3 -DSYS_VIMRC_FILE=\\\"/etc/vim/vimrc\\\""
CFGFLAGS="--prefix=$VIM_PREFIX \
          --with-features=small \
          --disable-gui \
          --disable-xsmp \
          --disable-xsmp-interact \
          --disable-netbeans \
          --disable-gpm \
          --enable-nls \
          --enable-acl \
          --disable-terminal \
          --disable-canberra \
          --disable-libsodium"
for arg in $@ ; do
  if [ "$arg" = 'full' ] ; then
    echo 'Build "full"'
    CFGFLAGS="--prefix=$VIM_PREFIX \
              --with-features=huge \
              --enable-multibyte \
              --enable-largefile \
              --enable-fail-if-missing \
              --enable-cscope \
              --disable-netbeans \
              --enable-gui=no \
              --with-x=yes"
  fi
done

_get () {
  if [ ! -d "$VIM_FOLDER" ] ; then
    if [ -f "$VIM_ARCHIVE" ] ; then
      xzcat "$VIM_ARCHIVE" | cpio -i
    else
      git clone --depth=1 --recursive \
        --branch="$VIM_GIT_BRANCH" "$VIM_REPO" "$VIM_FOLDER"
      cd "$VIM_FOLDER"
      rm -rf .git
      cd -
      find "$VIM_FOLDER" -print0 | cpio -0oHnewc \
        | xz -ze9T$THREADS > "$VIM_ARCHIVE"
    fi
  fi
}

_build () {
  cd "$VIM_FOLDER"
  CFLAGS="$CFLAGS" ./configure $CFGFLAGS
  make -j$THREADS
  touch "_built"
  cd -
}

_install () {
  cd "$VIM_FOLDER"
  sudo make install
  if [ ! -f "$VIM_PREFIX/bin/vi" ] ; then
    sudo ln -srvf "$VIM_PREFIX/bin/vim" "$VIM_PREFIX/bin/vi"
  fi
  cd -
}

_uninstall () {
  cd "$VIM_FOLDER"
  sudo make uninstall
  sudo rm -rvf "$VIM_PREFIX/bin/vi"
  cd -
}

if [ "$1" = "check" ] ; then
  echo "$VIM_GIT_BRANCH"
  if [ -d "$VIM_FOLDER" ] || [ -f "$VIM_ARCHIVE" ] ; then
    exit 0
  else
    exit 1
  fi
fi

for arg in $@ ; do if [ "$arg" = 'check' ] ; then echo "$VIM_GIT_BRANCH" ; exit 0 ; fi ; done

_get
if [ ! -f "$VIM_FOLDER/_built" ] ; then _build ; fi
for arg in $@ ; do if [ "$arg" = 'install' ] ; then _install ; exit 0 ; fi ; done
for arg in $@ ; do if [ "$arg" = 'uninstall' ] ; then _uninstall ; exit 0 ; fi ; done
