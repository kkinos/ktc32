ASM:=$(wildcard *.asm)
TARGET:=$(ASM:.asm=.mem)

.PHONY: all
all: $(TARGET)

%.mem: %.asm
	ktc32-asm $< -o $@ -b