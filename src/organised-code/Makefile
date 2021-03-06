C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o}

# Change this if your cross-compiler is somewhere else
CC = /usr/local/i386elfgcc/bin/i386-elf-gcc
LD = /usr/local/i386elfgcc/bin/i386-elf-ld
GDB = /usr/bin/gdb
# -g: Use debugging symbols in gcc
CFLAGS = -g
# --allow-multiple-definition: self explanatory
LFLAGS = --allow-multiple-definition

# First rule is run by default
os-img.bin: boot/bootsector.bin kernel.bin
	cat $^ > os-img.bin

# '--oformat binary' deletes all symbols as a collateral, so we don't need
# to 'strip' them manually on this case
kernel.bin: boot/kernel_entry.o ${OBJ}
	${LD} ${LFLAGS} -o $@ -Ttext 0x1000 $^ --oformat binary

# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
	${LD} ${LFLAGS} -o $@ -Ttext 0x1000 $^ 

run: os-img.bin
	qemu-system-x86_64 -fda os-img.bin

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-img.bin kernel.elf
	qemu-system-x86_64 -S -fda os-img.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

# Generic rules for wildcards
# To make an object, always compile from its .c
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-img.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o