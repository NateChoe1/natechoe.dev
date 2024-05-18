#!/bin/sh

cd $(dirname "$0")

create_entry() {
	file="$1"
	htmlfile="$(echo "$file" | sed 's/\..*$/.html/')"
	date=$(printf '%s\n' "$file" | grep -Eo "^[0-9]{4}-[0-9]{2}-[0-9]{2}")
	extension=$(printf '%s\n' "$file" | grep -o "\..*$")
	if [ "$extension" = ".ncdg" ] ; then
		title=$(sed -n "s/@=header \(.*\)@/\1/p" $file | head -n1)
		echo "/blog/$htmlfile \"$date - $title\""
	elif [ "$file" = "2022-02-23.txt" ] ; then
		echo "/blog/$file \"$date - I hate ASCII\""
	elif [ "$extension" != ".html" ] ; then
		echo "/blog/$file \"$date - Unrecognized post\""
	fi
}

ls -1 | grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort -r | while read file ; do
	create_entry "$file"
done > posts
