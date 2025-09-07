#!/bin/sh

cd $(dirname "$0")

create_entry() {
	file="$1"
	htmlfile="$(echo "$file" | sed 's/\..*$/.html/')"
	date=$(printf '%s\n' "$file" | cut -b 1-10 | sed 's/\//-/g')
	extension=$(printf '%s\n' "$file" | grep -o "\..*$")
	if echo "$extension" | grep -q '\.ignored$' ; then
		return
	fi
	if [ "$extension" = ".ncdg" ] ; then
		title=$(sed -n "s/@=header \(.*\)@/\1/p" $file | head -n1)
		echo "/blog/$htmlfile \"$date - $title\""
	elif [ "$extension" = ".nm" ] ; then
		title=$(head -n1 "$file" | cut -b 3-)
		echo "/blog/$htmlfile \"$date - $title\""
	elif [ "$file" = "2022/02/23/0-migrated.txt" ] ; then
		echo "/blog/$file \"$date - I hate ASCII\""
	elif [ "$extension" != ".html" ] ; then
		echo "/blog/$file \"$date - Unrecognized post\""
	fi
}

find . -type f -regextype egrep -regex '\./[0-9]{4}/.*' | cut -b 3- | sort -r | while read file ; do
	create_entry "$file"
done > posts
