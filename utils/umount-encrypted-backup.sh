#!/bin/sh

dev=$(/usr/sbin/blkid | grep d7e22ada-ef91-49da-bcf3-83d698a82f44 | cut -d':' -f1)

umount /media/backups

if [ $? -ne 0 ]; then
    echo "ERROR: Problems when unmounting LUKS device"
    exit 1
fi

/usr/sbin/cryptsetup close backups

if [ $? -ne 0 ]; then
    echo "ERROR on closing LUKS device"
    exit 1
fi

eject $dev
