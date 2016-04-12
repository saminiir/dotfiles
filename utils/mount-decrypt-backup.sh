#!/bin/sh

set -x

dev=$(/usr/sbin/blkid | grep d7e22ada-ef91-49da-bcf3-83d698a82f44 | cut -d':' -f1)

/usr/sbin/cryptsetup luksOpen --key-file /root/supersecretkey $dev backups

if [ $? -ne 0 -a $? -ne 5 ]; then
    echo "ERROR on opening LUKS device"
    exit 1
fi

mount /dev/mapper/backups /media/backups

if [ $? -ne 0 -a $? -ne 32 ]; then
    echo "ERROR: Problems when mounting LUKS device"
    exit 1
fi
