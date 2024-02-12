#!/bin/sh

HOSTNAME_FILE=/tor-data/natechoe-dev-onion/hostname

while ! [ -f "$HOSTNAME_FILE" ] ; do
	sleep 1
done

cat "$HOSTNAME_FILE"
