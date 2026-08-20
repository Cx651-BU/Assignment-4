all: matrix

CC=gcc
CFLAGS=-I. -lm

%.o: %.c 
	$(CC) -c -o $@ $< $(CFLAGS)

all: bench interactive test

bench: bench.o matrix.o
	$(CC) -o $@ $^ $(CFLAGS)

interactive: interactive.o scheduler.o matrix.o
	$(CC) -o $@ $^ $(CFLAGS)

test: test.o scheduler.o matrix.o
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm -f *.o
	rm -f matrix
	rm -f interactive
	rm -f test