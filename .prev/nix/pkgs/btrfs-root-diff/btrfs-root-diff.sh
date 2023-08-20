#!/usr/bin/env bash
# fs-diff.sh

set -u

DISK="/dev/disk/by-label/ROOT"
MOUNT_POINT="/mnt"
BLANK_SNAPSHOT="root-blank"
MOUNTED=0

mounpoint ${MOUNT_POINT} > /dev/null 2>&1

if [ $? -ne 0 ]
then
	# /mnt is not mounted
	sudo mkdir -p ${MOUNT_POINT}
	sudo mount -o subvol=/,ro ${DISK} ${MOUNT_POINT}
	MOUNTED=1
fi

set -uo pipefail
OLD_TRANSID=$(sudo btrfs subvolume find-new ${MOUNT_POINT}/${BLANK_SNAPSHOT} 9999999)
OLD_TRANSID=${OLD_TRANSID#transid marker was }


# Allow the changed subvolume to be specified on the command line.
# This is so we can keep track of changes to /home for example.
CHANGED_SUBVOLUME="root"
if [ $# -eq 1 ]; then
	CHANGED_SUBVOLUME=$1
fi

# NOTE: Make sure ${CHANGED_SUBVOLUME} is "quoted" to prevent things like 
# passing ;rm -rf /; as a command line argument.
sudo btrfs subvolume find-new "${MOUNT_POINT}/${CHANGED_SUBVOLUME}" "${OLD_TRANSID}" |
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
