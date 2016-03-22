    CC=gcc
    AR=ar
    RM=rm -fr
ACTION=@echo $@:$^
CFLAG=-c -fpic
#
#---------------------------------------------------------
# 0) show.o::show_init() calls util.o::util_init();
#
# 1) A not-complete .so file libdemo-n.so
#   show.o print.o
#
# 2) A complete .so file libdemo-c.so
# 	show.o print.o util.o
#
# 3) A not-complete .a file libdemo-n.a
#	show.o print.o
#
# 4) complete .a file libdemo-c.a
#	show.o print.o util.o
#

ifdef AORDER
CFLAG:=$(CFLAG) -DAORDER
endif

all:help

-include help.mk

libs: libdemo-n.so libdemo-c.so libdemo-n.a libdemo-c.a

#----------------------------------------------------------
# Build targets

main-na:main.o libdemo-n.a
	$(CC) -o $@ $< libdemo-n.a 

main-ca:main.o libdemo-c.a
	$(CC) -o $@ $< libdemo-c.a 

main-sca:main.o libdemo-c.a
	$(CC) -o $@ $< libdemo-c.a -static

main-sna:main.o libdemo-n.a
	$(CC) -o $@ $< libdemo-n.a -static

main-lna:main.o libdemo-n.a
	$(CC) -o $@ $< -L. -ldemo-n

main-lca:main.o libdemo-c.a
	$(CC) -o $@ $< -L. -ldemo-c

main-ns:main.o libdemo-n.so
	$(CC) -o $@ $< libdemo-n.so

main-cs:main.o libdemo-c.so
	$(CC) -o $@ $< libdemo-c.so

main-scs:main.o libdemo-c.so
	$(CC) -o $@ $< libdemo-c.so -static

main-lcs:main.o libdemo-c.so
	$(CC) -o $@ $< -L. -ldemo-c

main-o-order:main-o-order-0 main-o-order-1

main-o-order-0:main-order.o order.o debug.o
	$(CC) -o $@ main-order.o order.o debug.o

main-o-order-1:main-order.o order.o debug.o
	$(CC) -o $@ order.o debug.o main-order.o 

main-a-order-0: main.o liba.a libb.a
	$(CC) -o $@ main.o -L. -la -lb
main-a-order-1: main.o liba.a libb.a
	$(CC) -o $@ main.o -L. -lb -la 
# End Build targets
#----------------------------------------------------------

main.o:main.c
	$(CC) -c main.c -DNORMAL

main-order.o:main.c
	$(CC) -c main.c -o $@ -DOORDER

%.o:%.c
	$(CC) $(CFLAG) -o $@ $<

libdemo-n.so:show.o print.o
	$(CC) -shared -fPIC -o $@ $^

libdemo-c.so:show.o print.o util.o
	$(CC) -shared -fPIC -o $@ $^

libdemo-n.a:show.o print.o
	$(AR) -rc $@ $^

libdemo-c.a:show.o print.o util.o
	$(AR) -rc $@ $^

liba.a: print.o 
	$(AR) -rc $@ $^
libb.a: util.o show.o
	$(AR) -rc $@ $^

clean:
	$(RM) *.o *.so *.a
	$(RM) main-*
	$(RM) libdemo*

