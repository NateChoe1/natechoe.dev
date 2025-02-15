#!/bin/sh

if [ $# -lt 1 ] ; then
	echo "<p><b>Usage: $0 [language]</b></p>"
	echo "<p><b>If you're seeing this message, it means I've goofed up</b></p>"
	exit 1
fi

TMPDIR="$(mktemp -d)"
cat > "$TMPDIR/in"

echo -n "<pre><code>"
vim -E -s -c 'syntax on' -c "set ft=$1" -c 'runtime syntax/2html.vim' -c 'wqa' "$TMPDIR/in" > /dev/null 2>&1
sed -e '0,/<pre/d' -e '/<\/pre>/,$d' -e 's/<span class="/<span class="highlight-/g' "$TMPDIR/in.html"
echo -n "</code></pre>"
#rm -r "$TMPDIR"
