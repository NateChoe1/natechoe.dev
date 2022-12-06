SRCS = $(shell find -name *.ncdg)
BLOG = $(shell find site/blog | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}")
HTML = $(subst .ncdg,.html,$(SRCS))

all: $(HTML) site/sitemap.txt library.so site/blog/posts

library.so: library.c
	$(CC) $< -o $@ -shared -ansi -O2 -Wall -Wpedantic

site/blog/posts: site/blog/create-posts.sh $(BLOG)
	cd ./site/blog
	./site/blog/create-posts.sh

site/sitemap.txt: $(SRCS)
	find -name *.ncdg | sed "s/ncdg$$/html/g" | sed "s/^\.\/site/https:\/\/natechoe.dev/g" > $@
	echo "https://natechoe.dev/" >> $@

%.html: %.ncdg
	ncdg $< $@

.PHONY: all
