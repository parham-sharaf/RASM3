OBJS = rasm3.o length.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =

all: rasm3

%.o : %.s
	as -g $(LSTFLGS) $< -o $@
rasm3: $(OBJS)
	ld -o rasm3 -g $(OBJS) ../../obj/ascint64.o ../../obj/putch.o ../../obj/putstring.o ../../obj/strlength.o ../../obj/getstring.o ../../obj/int64asc.o