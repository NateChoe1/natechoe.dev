SRCS = $(shell find -name *.ncdg)
HTML = $(subst .ncdg,.html,$(SRCS))

all: $(HTML) site/sitemap.txt library.so

library.so: library.c
	$(CC) $< -o $@ -shared -ansi -O2 -Wall -Wpedantic

site/sitemap.txt: $(SRCS)
	find -name *.ncdg | sed "s/ncdg$$/html/g" | sed "s/^\.\/site/https:\/\/natechoe.dev/g" > $@
	echo "https://natechoe.dev/" >> $@

%.html: %.ncdg
	ncdg $< $@

.PHONY: all
