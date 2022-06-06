SRCS = $(shell find -name *.ncdg)
HTML = $(subst .ncdg,.html,$(SRCS))

all: $(HTML)

%.html: %.ncdg
	ncdg $< $@

.PHONY: all
