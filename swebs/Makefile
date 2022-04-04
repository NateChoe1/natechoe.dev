SRC = $(wildcard src/*.c)
OBJ = $(subst .c,.o,$(subst src,work,$(SRC)))
LIBS = gnutls
LDFLAGS = -pie -lrt -ldl $(shell pkg-config --libs $(LIBS))
CFLAGS := -O2 -pipe -Wall -Wpedantic -Wshadow -ansi
CFLAGS += -Isrc/ -D_POSIX_C_SOURCE=200809L -D__USE_OPEN_EXTENDED $(shell pkg-config --cflags $(LIBS))
INSTALLDIR := /usr/sbin
HEADERDIR := /usr/include/
INCLUDE_DIRECTORY := swebs
OUT = swebs

build/$(OUT): $(OBJ)
	$(CC) $(OBJ) -o build/$(OUT) $(LDFLAGS)

work/%.o: src/%.c $(wildcard src/swebs/*.h)
	$(CC) $(CFLAGS) $< -c -o $@

install: build/$(OUT)
	cp build/$(OUT) $(INSTALLDIR)/$(OUT)
	cp -r src/$(INCLUDE_DIRECTORY) $(HEADERDIR)/
	if ! id swebs >> /dev/null 2>&1; then useradd -M swebs; fi

uninstall: $(INSTALLDIR)/$(OUT)
	rm $(INSTALLDIR)/$(OUT)
	rm -r $(HEADERDIR)/$(INCLUDE_DIRECTORY)
	if id swebs >> /dev/null 2>&1; then userdel swebs; fi
