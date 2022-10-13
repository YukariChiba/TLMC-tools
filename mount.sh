#!/bin/bash

SOURCE_DIR="/home/yukari/cloud/TLMC v2"
TARGET_DIR="/home/yukari/Music/TLMC"

COLLECTIONS=()
cnt=0
while read -r FILEN; do
  cnt=$((cnt+1))
  COLLECTIONS+=($cnt "$FILEN" off)
done <TLMC.list

CHOICE=$(dialog --clear \
	--backtitle "Touhou Lossless Music Collection v2" \
	--title "Select a collection" \
	--separate-output \
	--checklist "Choose one of the following downloaded collection:" 40 0 4 \
	"${COLLECTIONS[@]}" \
	2>&1 >/dev/tty)
clear

for CHO in $CHOICE
do
	FILEN=$(cat TLMC.list | sed -n "${CHO}p")
	echo "mount $FILEN"
	mkdir -p "${TARGET_DIR}/${FILEN}"
	rar2fs "${SOURCE_DIR}"/"${FILEN}".rar "${TARGET_DIR}/${FILEN}"
done
