
CC=clang
CFLAGS=-O3 -march=native -mtune=native -flto -Iinclude -g3
PREFIX?=/usr/local

.PHONY: all clean format install

OBJECTS=obj/main.o obj/libsais.o obj/crc32.o obj/mtf.o obj/srt.o obj/rle.o \
        obj/cm.o obj/libbz3.o obj/txt.o obj/lzp.o

all: bzip3

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

bzip3: $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ -lm

clean:
	rm -f bzip3 obj/*.o

format:
	clang-format -i src/*.c include/*.h

install:
	install -v -m 755 bzip3 $(PREFIX)/bin
