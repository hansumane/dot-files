#!/bin/sh

# chmount.sh - shell script to mount, chroot, and umount easily

# nfs mount requirements:
# - /fs/nfs/nfs.ko
# - /fs/nfs/nfsv4.ko
# - /fs/lockd/lockd.ko
# - /net/sunrpc/sunrpc.ko
# - /net/sunrpc/auth_gss/auth_rpcgss.ko

if [ "$(id -u)" -eq 0 ] ; then
  SUDO_CMD=''
  HOME_PATH=''
else
  SUDO_CMD='sudo'
  HOME_PATH='HOME=/home/root'
fi

# MOUNT_PARAMS="-t nfs4 192.168.0.1:/srv/shared/image"
MOUNT_PARAMS="image.ext4"
# CHROOT_DIR="/alternate"
CHROOT_DIR="image"

if [ "$1" = "umount" ] ; then
  [ -f "$CHROOT_DIR/swap" ] && $SUDO_CMD swapoff "$CHROOT_DIR/swap"
  if ! $SUDO_CMD umount -R "$CHROOT_DIR" > /dev/null 2>&1 ; then
    echo "ERROR: Failed to umount -R; trying to umount everything w/o -R..."
      $SUDO_CMD umount "$CHROOT_DIR/tmp"
      $SUDO_CMD umount "$CHROOT_DIR/run"
    $SUDO_CMD umount "$CHROOT_DIR/dev/shm"
    $SUDO_CMD umount "$CHROOT_DIR/dev/pts"
    $SUDO_CMD umount "$CHROOT_DIR/dev"
      $SUDO_CMD umount "$CHROOT_DIR/sys/kernel/config"
      $SUDO_CMD umount "$CHROOT_DIR/sys/kernel/debug"
      $SUDO_CMD umount "$CHROOT_DIR/sys/fs/fuse/connections"
      $SUDO_CMD umount "$CHROOT_DIR/sys/fs/pstore"
      $SUDO_CMD umount "$CHROOT_DIR/sys/fs/cgroup/unified"
      $SUDO_CMD umount "$CHROOT_DIR/sys/fs/cgroup/openrc"
      $SUDO_CMD umount "$CHROOT_DIR/sys/fs/cgroup"
      $SUDO_CMD umount "$CHROOT_DIR/sys"
    $SUDO_CMD umount "$CHROOT_DIR/proc"
      $SUDO_CMD umount "$CHROOT_DIR"
  fi
  exit 0
fi

set -e

if [ ! -d "$CHROOT_DIR/bin" ] ; then
  mkdir -p "$CHROOT_DIR"
    $SUDO_CMD mount $MOUNT_PARAMS "$CHROOT_DIR"
    [ -f "/etc/resolv.conf" ] && $SUDO_CMD cp /etc/resolv.conf "$CHROOT_DIR/etc"
  $SUDO_CMD mount -t proc /proc "$CHROOT_DIR/proc"
    $SUDO_CMD mount --rbind /sys "$CHROOT_DIR/sys"
    $SUDO_CMD mount --make-rslave "$CHROOT_DIR/sys"
  $SUDO_CMD mount --rbind /dev "$CHROOT_DIR/dev"
  $SUDO_CMD mount --make-rslave "$CHROOT_DIR/dev"
    $SUDO_CMD mount --bind /run "$CHROOT_DIR/run"
    $SUDO_CMD mount --make-slave "$CHROOT_DIR/run"
  $SUDO_CMD mount --bind /tmp "$CHROOT_DIR/tmp"
  $SUDO_CMD mount --make-slave "$CHROOT_DIR/tmp"
    [ -f "$CHROOT_DIR/swap" ] && $SUDO_CMD swapon "$CHROOT_DIR/swap"
fi

$SUDO_CMD $HOME_PATH chroot "$CHROOT_DIR" /bin/bash
