SRCS = $(shell find -name *.ncdg)
BLOG = $(shell find site/blog | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}")
HTML = $(SRCS:.ncdg=.html)
CDEPS = /tor-data/natechoe-dev-onion/hostname /site/head.html /site/tail.html

all: $(HTML) asm site/blog/blog.rss site/sitemap.txt library.so site/blog/posts

asm: favicon.ico site/resources/88x31.bmp site/resources/88x31-bw.png

library.so: library.c
	$(CC) $< -o $@ -shared -O2 -Wall -Wpedantic

site/blog/posts: site/blog/create-posts.sh $(BLOG)
	cd ./site/blog
	./site/blog/create-posts.sh

site/sitemap.txt: $(HTML) site/blog/blog-index/update-check
	find site -name '*.html' | sed "s/^\.\/site/https:\/\/natechoe.dev/g" > $@
	echo "https://natechoe.dev/" >> $@

site/blog/blog-index/update-check: site/blog/blog-index/create-index.sh site/blog/posts /tor-data/natechoe-dev-onion/hostname create-hub.sh $(wildcard site/blog/blog-index/*.tempate)
	$<

site/blog/blog.rss: site/blog/rss.xncdg site/blog/posts
	ncdg $< $@

site/misc/comp/index.html: site/misc/comp/index.ncdg site/misc/comp/links create-hub.sh $(CDEPS)
site/misc/tools/index.html: site/misc/tools/index.ncdg site/misc/tools/tools create-hub.sh $(CDEPS)
site/misc/index.html: site/misc/index.ncdg site/misc/links create-hub.sh $(CDEPS)
site/misc/comp/index.html: site/misc/comp/index.ncdg site/misc/comp/links $(CDEPS)

%.html: %.ncdg $(CDEPS)
	ncdg $< $@

favicon.ico: favicon.asm
	nasm -f bin $< -o $@
	chown swebs:swebs $@

site/resources/88x31.bmp: site/resources/88x31.asm
	nasm -f bin $< -o $@
	chown swebs:swebs $@
site/resources/88x31-bw.png: site/resources/88x31-bw.pbm
	convert $< $@
	chown swebs:swebs $@

.PHONY: all asm
