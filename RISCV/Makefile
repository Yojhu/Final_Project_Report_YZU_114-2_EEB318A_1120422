# Makefile
CC = riscv64-unknown-elf-gcc
OBJCOPY = riscv64-unknown-elf-objcopy
CFLAGS = -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -O2

all: firm.mem

firm.elf: start.S main.c linker.ld
	$(CC) $(CFLAGS) -T linker.ld start.S main.c -o firm.elf -lgcc

firm.bin: firm.elf
	$(OBJCOPY) -O binary firm.elf firm.bin

firm.mem: firm.bin
	# 將二進位轉成 Vivado $readmemh 讀取相符的 32-bit 十六進位格式 
	od -v -t x4 -An -w4 firm.bin | tr -d ' ' > firm.mem

clean:
	rm -f firm.elf firm.bin firm.mem
