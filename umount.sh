#!/bin/bash

MOUNT_PATH=/home/yukari/Music/TLMC

mount | grep "rar2fs on $MOUNT_PATH" \
	| grep -o 'rar2fs on .* type fuse.rar2fs' \
	| sed 's/^rar2fs on //g' \
	| sed 's/ type fuse.rar2fs$//g' \
	| rev | cut -d '/' -f 1 | rev \
	> TLMC.mounted.list

COLLECTIONS=()
cnt=0
while read -r FILEN; do
  cnt=$((cnt+1))
  COLLECTIONS+=($cnt "$FILEN" off)
done <TLMC.mounted.list

CHOICE=$(dialog --clear \
	--backtitle "Touhou Lossless Music Collection v2" \
	--title "Select collections" \
	--separate-output \
	--checklist "Choose some of the following mounted collection:" 0 0 4 \
	"${COLLECTIONS[@]}" \
	2>&1 >/dev/tty)
clear

for CHO in $CHOICE
do
	FILEN=$(cat TLMC.mounted.list | sed -n "${CHO}p")
	echo "unmount $FILEN"
	fusermount -u "$MOUNT_PATH/$FILEN"
done
