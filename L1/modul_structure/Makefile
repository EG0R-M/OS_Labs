CC = gcc
CFLAGS = -Wall -Wextra -O2
TARGET = program.exe
OBJS = main.o fibonacci.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^

main.o: main.c fibonacci.h
	$(CC) $(CFLAGS) -c $< -o $@

fibonacci.o: fibonacci.c fibonacci.h
	$(CC) $(CFLAGS) -c $< -o $@

# Параллельная версия (процессы)
parallel: parallel.exe

parallel.exe: parallel.c fibonacci.c fibonacci.h
	$(CC) -o $@ parallel.c fibonacci.c $(CFLAGS)

run_parallel: parallel.exe
	.\parallel.exe

run_parallel15: parallel.exe
	.\parallel.exe 15

clean:
	del *.o *.exe 2>nul

clean_parallel:
	del parallel.exe result.txt 2>nul

.PHONY: all clean run_parallel