#Name of the final executable file
EXECUTABLE = rasm3

#This is meant for any external files not contained within the project
#Mostly the professor's function object files
EXTERNAL = ../obj/ascint64.o ../obj/putch.o ../obj/putstring.o ../obj/strlength.o ../obj/int64asc.o ../obj/getstring.o /usr/lib/aarch64-linux-gnu/libc.so

#Automatically deduces corresponding .o files of .s files in this directory and all subdirectories
_OBJECTS := $(patsubst %.s, %.o, $(shell find * -type f -name '*.s'))

#Main rules ------
all: $(EXECUTABLE)

$(EXECUTABLE): $(_OBJECTS)
	ld -g $^ $(EXTERNAL) -o $(EXECUTABLE) -dynamic-linker /lib/ld-linux-aarch64.so.1

$(_OBJECTS): %.o: %.s
	as -g $< -o $@


#Extra commands ------
.PHONY: clean gef run
clean:
	rm $(_OBJECTS) $(EXECUTABLE)
gef: $(EXECUTABLE)
	gdb $(EXECUTABLE)
run: $(EXECUTABLE)
	./$(EXECUTABLE)