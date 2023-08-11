#!/usr/bin/env bash
# fs-diff.sh

set -u

MOUNTED=0

mounpoint /mnt > /dev/null 2>&1

if [ $? -ne 0 ]
then
	# /mnt is not mounted
	sudo mkdir -p /mnt
	sudo mount -o subvol=/,ro /dev/mapper/enc /mnt
	MOUNTED=1
fi

set -uo pipefail
OLD_TRANSID=$(sudo btrfs subvolume find-new /mnt/root-blank 9999999)
OLD_TRANSID=${OLD_TRANSID#transid marker was }

sudo btrfs subvolume find-new "/mnt/root" "${OLD_TRANSID}" |
	sed '$d' | cut -f17- -d' ' | sort -u |
	while read path; do
		path="/$path"
		if [ -L "$path" ] || [ -d "$path" ]
		then
			:
		else
			echo $path
		fi
	done


if [ $MOUNTED -eq 1 ]
then
	sudo umount /mnt
fi
