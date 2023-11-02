LDFLAGS=-lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64

%.o: %.s
	as $< -o $@

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).c $(LFLAGS)

all: bindshell shell

bindshell: bindshell.o
	ld $(LDFLAGS) -o bindshell.macho bindshell.o

shell: shell.o
	ld $(LDFLAGS) -o shell.macho shell.o

print: print.o
	ld $(LDFLAGS) -o print.macho print.o

loader:
	clang -o loader loader.c

clean:
	rm -f *.o *.macho loader