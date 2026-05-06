#!/usr/bin/env bash

# chmount.sh - shell script to mount, chroot, and umount easily

# nfs mount required kernel modules:
# - /fs/nfs/nfs.ko
# - /fs/nfs/nfsv4.ko
# - /fs/nfs_common/grace.ko
# - /fs/lockd/lockd.ko
# - /net/sunrpc/sunrpc.ko
# - /net/sunrpc/auth_gss/auth_rpcgss.ko

# NOTE: to mount 'projects', '.placeholder' file must be inside 'projects'

(( EUID != 0 )) && SUDO=sudo || SUDO=

# MOUNT_PARAMS='-t nfs4 192.168.0.1:/srv/shared/image'
MOUNT_PARAMS='image.ext4'
# CHROOT_DIR='/alternate'
CHROOT_DIR='rootfs'

ENV=('HOME=/home/root')

if [[ "$1" = 'umount' ]] ; then
  if [[ -f "$CHROOT_DIR/swap" ]] ; then
    $SUDO swapoff "$CHROOT_DIR/swap"
  fi

  if ! $SUDO umount -R "$CHROOT_DIR" > /dev/null 2>&1 ; then
    echo 'ERROR: Failed to umount -R; trying to umount everything w/o -R...'

    if [[ -f "$CHROOT_DIR/home/root/projects/.placeholder" ]] ; then
      $SUDO umount "$CHROOT_DIR/home/root/projects"
    fi

    $SUDO umount "$CHROOT_DIR/tmp"
    $SUDO umount "$CHROOT_DIR/run"

    $SUDO umount "$CHROOT_DIR/dev/shm"
    $SUDO umount "$CHROOT_DIR/dev/pts"
    $SUDO umount "$CHROOT_DIR/dev"

    $SUDO umount "$CHROOT_DIR/sys/kernel/config"
    $SUDO umount "$CHROOT_DIR/sys/kernel/debug"
    $SUDO umount "$CHROOT_DIR/sys/fs/fuse/connections"
    $SUDO umount "$CHROOT_DIR/sys/fs/pstore"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/debug"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/misc"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/rdma"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/pids"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/perf_event"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/freezer"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/devices"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/memory"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/blkio"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/cpuacct"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/cpu"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/cpuset"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/unified"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup/openrc"
    $SUDO umount "$CHROOT_DIR/sys/fs/cgroup"
    $SUDO umount "$CHROOT_DIR/sys"

    $SUDO umount "$CHROOT_DIR/proc"

    $SUDO umount "$CHROOT_DIR"
  fi

  exit 0
fi

set -e

if [[ ! -d "$CHROOT_DIR/bin" ]] ; then
  mkdir -p "$CHROOT_DIR"

  $SUDO mount $MOUNT_PARAMS "$CHROOT_DIR"

  if [[ -f '/etc/resolv.conf' ]] ; then
    $SUDO cp '/etc/resolv.conf' "$CHROOT_DIR/etc"
  fi

  $SUDO mount -t proc       '/proc' "$CHROOT_DIR/proc"

  $SUDO mount --rbind       '/sys'  "$CHROOT_DIR/sys"
  $SUDO mount --make-rslave         "$CHROOT_DIR/sys"

  $SUDO mount --rbind       '/dev'  "$CHROOT_DIR/dev"
  $SUDO mount --make-rslave         "$CHROOT_DIR/dev"

  $SUDO mount --bind        '/run'  "$CHROOT_DIR/run"
  $SUDO mount --make-slave          "$CHROOT_DIR/run"

  $SUDO mount --bind        '/tmp'  "$CHROOT_DIR/tmp"
  $SUDO mount --make-slave          "$CHROOT_DIR/tmp"

  if [[ -f 'projects/.placeholder' ]] ; then
    $SUDO mkdir -p                      "$CHROOT_DIR/home/root/projects"
    $SUDO mount --bind       'projects' "$CHROOT_DIR/home/root/projects"
    $SUDO mount --make-slave            "$CHROOT_DIR/home/root/projects"
  fi

  if [[ -f "$CHROOT_DIR/swap" ]] ; then
    $SUDO swapon "$CHROOT_DIR/swap"
  fi
fi

$SUDO ${ENV[@]} chroot "$CHROOT_DIR" /bin/bash
