#!/bin/sh

cd $(dirname "$0")

POSTS_FILE="../posts"
POSTS_LEN="$(cat "$POSTS_FILE" | wc -l)"
PAGE_LEN=10
export TMP_FILE=posts.tmp

LIMIT=$(expr "(" "$POSTS_LEN" "+" "$PAGE_LEN" "-" "1" ")" "/" "$PAGE_LEN" )

parsetemp() {
	cat "$1" | sed "s/__BLOG_INDEX_NO__/$3/g" | sed "s/__BLOG_BUTTON_TITLE__/$4/g" > "$2"
}

# This could be moved to index.ncdg.template, but I don't want to.
for x in $(seq $LIMIT) ; do
	cat "$POSTS_FILE" | tail -n+$(expr \( $x - 1 \) \* $PAGE_LEN + 1) | head -n$PAGE_LEN > $TMP_FILE
	export PREV_FILE=prev.tmp
	export NEXT_FILE=next.tmp
	PREV_TEMPLATE=""
	if [ $x -eq 1 ] ; then
		PREV_TEMPLATE=unselected.ncdg.template
	else
		PREV_TEMPLATE=selected.ncdg.template
	fi
	NEXT_TEMPLATE=""
	if [ $x -eq $LIMIT ] ; then
		NEXT_TEMPLATE=unselected.ncdg.template
	else
		NEXT_TEMPLATE=selected.ncdg.template
	fi

	parsetemp $PREV_TEMPLATE $PREV_FILE $(expr $x - 1) "\&lt; newer blogs"
	parsetemp $NEXT_TEMPLATE $NEXT_FILE $(expr $x + 1) "older blogs \&gt;"

	ncdg index.ncdg.template > index-$x.html
	rm $PREV_FILE $NEXT_FILE
done

rm *.tmp
