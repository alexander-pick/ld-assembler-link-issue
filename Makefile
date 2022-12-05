CC = gcc
LD = ld

all:
	${CC} test.s -o test2.o -c
	${CC} test.c -o test.o -c
	${CC} test.o test2.o -o testfinal -v
clean:
	rm -f testfinal
	rm *.o
run: 
	make all
	objdump -x testfinal | grep STACK -n2
