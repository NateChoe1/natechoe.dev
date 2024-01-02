SRCS = $(shell find -name *.ncdg)
BLOG = $(shell find site/blog | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}")
HTML = $(subst .ncdg,.html,$(SRCS))

all: $(HTML) favicon.ico site/sitemap.txt library.so site/blog/posts

library.so: library.c
	$(CC) $< -o $@ -shared -O2 -Wall -Wpedantic

site/blog/posts: site/blog/create-posts.sh $(BLOG)
	cd ./site/blog
	./site/blog/create-posts.sh

site/sitemap.txt: $(SRCS)
	find -name *.ncdg | sed "s/ncdg$$/html/g" | sed "s/^\.\/site/https:\/\/natechoe.dev/g" > $@
	echo "https://natechoe.dev/" >> $@

site/blog/index.html: site/blog/index.ncdg site/blog/posts
	ncdg site/blog/index.ncdg site/blog/index.html

%.html: %.ncdg
	ncdg $< $@

favicon.ico: favicon.asm
	nasm -f bin $< -o $@
	chown swebs:swebs $@

.PHONY: all
