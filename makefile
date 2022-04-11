OBJS = rasm3.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =

all: rasm3

%.o : %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@
rasm3: $(OBJS)
	ld -o rasm3 /usr/lib/aarch64-linux-gnu/libc.so rasm3.o -dynamic-linker /lib/ld-linux-aarch64.so.1 ../obj/ascint64.o ../obj/putch.o ../obj/putstring.o ../obj/strlength.o ../obj/getstring.o ../obj/int64asc.o
