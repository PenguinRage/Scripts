# Recovery Laptop script
# Run as root

#!/bin/bash

cryptsetup open --type luks /dev/sda2 root

mount -t ext4 /dev/mapper/root /mnt

mount /dev/sda1 /mnt/boot
mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

cp /etc/resolv.conf /mnt/etc/resolv.conf

chroot /mnt /bin/bash
