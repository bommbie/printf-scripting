#!/usr/bin/sh

if [ $# -eq 0 ]; then
	printf "Es wurde kein Parameter übergeben!\n"
	printf "Verwendung %s <dein Parameter>\n" "$0"
	exit 1
fi

programname="$0"
parameter="$1"

printf "Das Programm heißt: %s\n" "$programname"
printf "Als Parameter wurde %s übergeben\n" "$parameter"
