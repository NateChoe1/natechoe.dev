#!/bin/sh

if [ $# -lt 1 ] ; then
	echo "Usage: $0 [posts file]"
	exit 1
fi

while read LINE ; do
	eval set -- "$LINE"
	cat << EOF
<item>
<title>$2</title>
<author>nate@natechoe.dev (Nate Choe)</author>
<link>https://natechoe.dev$1</link>
<guid>https://natechoe.dev$1</guid>
</item>
EOF
done <"$1"
