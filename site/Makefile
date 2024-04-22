SRCS = $(shell find -name *.ncdg)
BLOG = $(shell find site/blog | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}")
HTML = $(subst .ncdg,.html,$(SRCS))

all: $(HTML) asm site/sitemap.txt library.so site/blog/posts

asm: favicon.ico site/resources/88x31.bmp

library.so: library.c
	$(CC) $< -o $@ -shared -O2 -Wall -Wpedantic

site/blog/posts: site/blog/create-posts.sh $(BLOG)
	cd ./site/blog
	./site/blog/create-posts.sh

site/sitemap.txt: $(HTML) site/blog/blog-index/update-check
	find site -name '*.html' | sed "s/^\.\/site/https:\/\/natechoe.dev/g" > $@
	echo "https://natechoe.dev/" >> $@

site/blog/blog-index/update-check: site/blog/blog-index/create-index.sh site/blog/posts /tor-data/natechoe-dev-onion/hostname
	$<

%.html: %.ncdg /tor-data/natechoe-dev-onion/hostname
	ncdg $< $@

favicon.ico: favicon.asm
	nasm -f bin $< -o $@
	chown swebs:swebs $@

site/resources/88x31.bmp: site/resources/88x31.asm
	nasm -f bin $< -o $@
	chown swebs:swebs $@

.PHONY: all asm
