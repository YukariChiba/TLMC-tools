#!/bin/bash

while read -r FILEN; do
	FLACF=`echo $FILEN | sed "s/\.cue$/\.flac/g"`
	if [ -f "./${FLACF}" ]; then
		DIRN=`dirname "$FLACF"`
		EXI=`ls "$DIRN" | grep '.flac$' | wc -l`
		if test "$EXI" -eq "1"
		then
            shnsplit -o flac -f "$FILEN" "$FLACF" -t "(%n) [%p] %t"
		fi
	fi
done < <(find . -name "*.cue")