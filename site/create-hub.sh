#!/bin/bash

# Creates a table of contents (hub) for your page.

if [ $# -lt 1 ] ; then
	echo "<p>$0 called without any arguments. If you see this, contact the
	site owner. If the site owner isn't nate@natechoe.dev, please tell them
	to stop using ncdg.</p>"
	exit
fi

FILE="$1"
ITEMS="$2"

echo "<div class=hubtitle><b>$(wc -l < "$FILE") "$ITEMS"</b></div>"
while read LINE ; do
	eval set -- "$LINE"
	echo "<a class=hubitem class=hublink href=$1>$2<div class=rightarrow></div></a>"
done <"$FILE"
