# Recovery Laptop script
# Run as root

#!/bin/bash

sudo su

cryptsetup luksOpen /dev/sda2 ssd
cryptsetup luksOpen /dev/sda3 swap

mount /dev/mapper/ssd /mnt
mount /dev/sda1 /mnt/boot/efi

mount -t proc proc /mnt/proc
mount -t sysfs sys /mnt/sys
mount -o bind /dev /mnt/dev
mount -t devpts pts /mnt/dev/pts/
mount -o bind /run /mnt/run
cp /etc/resolv.conf /mnt/etc/resolv.conf

chroot /mnt
