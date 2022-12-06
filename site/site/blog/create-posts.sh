#!/bin/sh

cd $(dirname $0)

files=$(ls | grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}\." | sort)

create_entry() {
	file=$1
	date=$(echo $file | grep -Eo "^[0-9]{4}-[0-9]{2}-[0-9]{2}")
	extension=$(echo $file | grep -o "\..*$")
	if [ $extension = ".ncdg" ] ; then
		title=$(grep -o "@=header .*@" $file | cut -b 10- | sed "s/@$//")
		echo "/blog/$date.html \"$date - $title\""
	elif [ $file = "2022-02-23.txt" ] ; then
		echo "/blog/$file \"$date - I hate ASCII\""
	else
		echo "/blog/$file \"$date - Unrecognized post\""
	fi
}

create_entries() {
	for file in $@ ; do
		create_entry "$file"
	done
}

create_entries $files > posts
