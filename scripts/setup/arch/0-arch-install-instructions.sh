#!/usr/bin/env bash
exit 0  # you shouldn't run this script

# ---------------------------------------------------------------------------------------
# prerequisites
# ---------------------------------------------------------------------------------------

# set preferred font
setfont <your_console_font> # e.g. ter-k18n

# setup wifi connection
wifi-menu
# or
ip a  # look for wlan or something similar
iwctl
  station <wlan_interface> connect <SSID>
  <passphrase>
  exit
# if it didn't work try this
rfkill unblock wifi
ip link set <wlan_interface> up

# check internet connection
ping archlinux.org -c1

# set up network time protocol (it's not necessary until the time is very wrong)
timedatectl set-ntp true
timedatectl status

# ---------------------------------------------------------------------------------------
# partitioning: prerequisites
# ---------------------------------------------------------------------------------------

# get what's yours <disk>
fdisk -l  # look for sd<X>, vd<X>, hd<X>, nvme<X>, etc...
# or
lsblk

# setup partitions (-z flag is optional if you want to clean disk)
cfdisk <-z> /dev/<disk><X>  # /dev/sda

# ---------------------------------------------------------------------------------------
# partitioning: how to create btrfs root without encryption (for encryption look further)
# ---------------------------------------------------------------------------------------

# create partitions something alike with cfdisk
1M    BIOS boot         # is only required if you use GPT with BIOS
512M  EFI               # for /boot/efi partition
                        # is only required if you have BIOS boot or UEFI on GPT
2-4G  Linux filesystem  # for /boot partition
?G    Linux swap        # see swap size reference in Wiki (optional)
MAX   Linux filesystem  # for root partition

# initialize btrfs partition on root partition
mkfs.btrfs -f /dev/<disk><X><N>  # /dev/sda4

# create btrfs subvolumes
mount /dev/<disk><X><N> /mnt  # /dev/sda4
btfs su cr /mnt/@
btfs su cr /mnt/@home
btfs su cr /mnt/@log
umount -R /mnt

# mount btrfs partitions (-m for --mkdir, -o for --options)
mount -o ssd,compress=zstd:1,defaults,noatime,discard=async,subvol=@ \
         /dev/<disk><X><N> /mnt
         # /dev/sda4
mount -m -o ssd,compress=zstd:1,defaults,noatime,discard=async,subvol=@home \
            /dev/<disk><X><N> /mnt/home
            # /dev/sda4
mount -m -o ssd,compress=zstd:1,defaults,noatime,discard=async,subvol=@log \
            /dev/<disk><X><N> /mnt/var/log
            # /dev/sda4

# if using swap partition
mkswap /dev/<disk><X><N> # /dev/sda3
swapon /dev/<disk><X><N> # /dev/sda3

# make /boot and /boot/efi partitions filesystems
mkfs.fat -F32 /dev/<disk><X><N> # /dev/sda1
mkfs.ext4 /dev/<disk><X><N>     # /dev/sda2

# mount /boot and /boot/efi partitions
mount -m -o defaults,noatime,discard \
            /dev/<disk><X><N> /mnt/boot

# ---------------------------------------------------------------------------------------
# partitioning: how to create btrfs on LVM on LUKS
# ---------------------------------------------------------------------------------------

# creating partition table and partitions
fdisk -l                    # look for sd<X>, vd<X>, hd<X>, nvme<X>, etc...
cfdisk <-z> /dev/<disk><X>  # -z flag is optional if you want to clean disk

# create partitions something alike
1M    BIOS boot         # is only required if you use GPT with BIOS
512M  EFI               # for /boot/efi partition
                        # is only required if you have BIOS boot or UEFI on GPT
2-4G  Linux filesystem  # for /boot partition
MAX   Linux LVM         # for encrypted LVM (/dev/sda1)

# setup encryption on MAX partition
cryptsetup luksFormat /dev/<disk><X><N>       # /dev/sda3
cryptsetup open /dev/<disk><X><N> <cryptname> # /dev/sda3; cryptlvm

# create volume group and group partitions
pvcreate /dev/mapper/<cryptname>                        # /dev/mapper/cryptlvm
vgcreate <volumegroupname> /dev/mapper/<cryptname>      # main; /dev/mapper/cryptlvm
lvcreate -L <size><K|M|G> <volumegroupname> -n <lvname> # 8G; main; swap (optional)
lvcreate -l 100%FREE <volumegroupname> -n <rootlvname>  # main; root

# initialize btrfs partition on rootlv
mkfs.btrfs -f /dev/mapper/<volumegroupname>-<rootlvname>  # /dev/mapper/main-root

# create btrfs subvolumes
mount /dev/mapper/<volumegroupname>-<rootlvname> /mnt     # /dev/mapper/main-root
btfs su cr /mnt/@
btfs su cr /mnt/@home
btfs su cr /mnt/@log
umount -R /mnt

# mount btrfs partitions (-m for --mkdir, -o for --options)
mount -o ssd,compress=zstd:1,defaults,noatime,discard=async,subvol=@ \
         /dev/mapper/<volumegroupname>-<rootlvname> /mnt
         # /dev/mapper/main-root
mount -m -o ssd,compress=zstd:1,defaults,noatime,discard=async,subvol=@home \
            /dev/mapper/<volumegroupname>-<rootlvname> /mnt/home
            # /dev/mapper/main-root
mount -m -o ssd,compress=zstd:1,defaults,noatime,discard=async,subvol=@log \
            /dev/mapper/<volumegroupname>-<rootlvname> /mnt/var/log
            # /dev/mapper/main-root

# if using swap partition
mkswap /dev/mapper/<volumegroupname>-<lvname> # /dev/mapper/main-swap
swapon /dev/mapper/<volumegroupname>-<lvname> # /dev/mapper/main-swap

# make /boot and /boot/efi partitions filesystems
mkfs.fat -F32 /dev/<disk><X><N> # /dev/sda1
mkfs.ext4 /dev/<disk><X><N>     # /dev/sda2

# mount /boot partition
mount -m -o defaults,noatime,discard \
            /dev/<disk><X><N> /mnt/boot
            # /dev/sda2

# mount /boot/efi partition
mount -m /dev/<disk><X><N> /mnt/boot/efi  # /dev/sda1

# ---------------------------------------------------------------------------------------
# installing base packages and settings
# ---------------------------------------------------------------------------------------

# optimize pacman
nvim /etc/pacman.conf # remove '#' before Color and
                      # ParallelDownloads = 5

# install lvm2 only if using encrypted setup
pacstrap -i /mnt base base-devel <lvm2> \
                 linux<-zen/-lts> linux<-zen/-lts>-headers linux-firmware \
                 terminus-font curl wget git zip unzip tar gzip bzip2 xz \
                 neovim zsh eza

# create fstab (use -U flag to mount partitions by their UUID)
genfstab <-U> /mnt >> /mnt/etc/fstab

# change root into newly setup system
arch-chroot /mnt

# change timezone and sync hardware time
ln -sf /usr/share/zoneinfo/<Region>/<City> /etc/localtime
hwclock --systohc

# edit fstab (generated by genfstab) if you wish
nvim /etc/fstab

# set up locale
nvim /etc/locale.gen && locale-gen
nvim /etc/locale.conf   # write 'LANG="<your_locale>"
                        #        LC_COLLATE="C"'
nvim /etc/vconsole.conf # write 'KEYMAP="us"
                        #        FONT="<your_console_font>"'

# setting up domain
nvim /etc/hostname  # write '<hostname>', e.g. archpc
nvim /etc/hosts # write '127.0.0.1       localhost
                #        127.0.0.1       localhost.localdomain
                #        ::1             ipv6-localhost ipv6-loopback
                #        fe00::0         ipv6-localnet
                #        ff00::0         ipv6-mcastprefix
                #        ff02::1         ipv6-allnodes
                #        ff02::2         ipv6-allrouters
                #        ff02::3         ipv6-allhosts'

# create user
EDITOR=nvim visudo  # remove '#' before %wheel ALL=(ALL) ALL
                    # so your user account gets root access
useradd -m <username> -c "<full_name>"  # myuser; Firstname Lastname
usermod -aG wheel,audio,video,<...>,<...> <username>
passwd  # change root password
passwd <userlogin>  # change user password

# optimize pacman
nvim /etc/pacman.conf # remove '#' before Color and
                      # ParallelDownloads = 4
# only if you with to use 32bit applications:
                      # remove '#' before [multilib] and
                      # next line include

# install grub and network manager
# you can also have dhcpcd or dhclient but they are optional
# os-prober and ntfs-3g are only required if you dual-boot alongside Windows
pacman -Sy grub efibootmgr networkmanager <os-prober> <ntfs-3g>

# ---------------------------------------------------------------------------------------
# NOTE: only if using encrypted partition

# edit /etc/mkinitcpio.conf
HOOKS=(base udev autodetect modconf         # udev after base
       kms keyboard keymap consolefont      # keyboard, keymap, consolefont after kms
       block encrypt lvm2 filesystems fsck) # encrypt, lvm2 after block

# only if you did encrypted lvm2 btrfs and mount
nvim /etc/mkinitcpio.conf  # write 'encrypt lvm2'
                           # after keyboard and before fsck
# ---------------------------------------------------------------------------------------

# setting up core, only choose one command to execute
# first is better if you have only one kernel,
# use second if you have multiple kernels
mkinitcpio -P
mkinitcpio -p linux-zen

# ---------------------------------------------------------------------------------------
# setting up bootloader (GRUB)
# ---------------------------------------------------------------------------------------

# edit default grub config
nvim /etc/default/grub

# ---------------------------------------------------------------------------------------
# NOTE: only if using encrypted partition

# get partition's UUID:
ls -la /dev/disk/by-uuid

# add this to GRUB_CMDLINE_LINUX_DEFAULT="... <here>" in /etc/default/grub
# (after arch-chroot)
"cryptdevice=UUID=UUID(<disk><X><N>):<cryptname> root=/dev/<volumegroupname>/<rootlvname>"
# UUID(/dev/sda1) => fcbaba33-0d2a...; cryptlvm; MyVolGroup; root
# ---------------------------------------------------------------------------------------

# installing grub bootloader for BIOS
grub-install /dev/sda

# installing grub bootloader for BIOS with GPT
grub-install --efi-directory=/boot/efi --bootloader-id=GRUB /dev/<disk><X>

# installing grub bootloader for UEFI
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

# making grub config
grub-mkconfig -o /boot/grub/grub.cfg

# ---------------------------------------------------------------------------------------
# network and time
# ---------------------------------------------------------------------------------------

# enable NetworkManager service
systemctl enable NetworkManager

# enable network time protocol again for installed system
timedatectl set-local-rtc 1 # if you wish you BIOS/UEFI time to be in your local tz
timedatectl set-ntp true; sleep 10
hwclock --systohc

# ---------------------------------------------------------------------------------------
# finish
# ---------------------------------------------------------------------------------------

exit
umount -R /mnt
reboot

# login to user and setup internet connection using NetworkManager:
# example for wifi
sudo nmcli d wifi connect <SSID> password <password>
# or
sudo nmtui  # NetworkManager text ui

# continue with postinstall or not, whatever you want
sudo pacman -Sy --needed curl wget git zip unzip tar gzip bzip2 xz neovim zsh exa

# ---------------------------------------------------------------------------------------
# sysctl config (edit /etc/sysctl.conf)
# ---------------------------------------------------------------------------------------

# change swap usage
vm.swappiness = 10
vm.vfs_cache_pressure = 50

# ip forwarding
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
