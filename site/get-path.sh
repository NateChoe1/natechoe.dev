#!/bin/sh

if [ $# -lt 1 ] ; then
	echo "ERROR: $0 called without an argument"
	exit 1
fi

realpath "$1" | sed -e 's/^\/site\/site//' -e 's/ncdg$/html/'
