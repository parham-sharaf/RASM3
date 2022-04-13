OBJS = String_indexOf_2.o

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
	ld -o rasm3 String_indexOf_2.o
