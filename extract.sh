#!/bin/bash

SRC_URL=example.com

while read -r FILEN; do
	if [ ! -d "./${FILEN}" ]; then
  		wget "http://${SRC_URL}/${FILEN}.rar" --limit-rate=80M
		unrar x "${FILEN}.rar"
		rm "${FILEN}.rar"
	fi
done <./TLMC.list
