MAKEFLAGS = -sR
MKDIR = mkdir
RMDIR = rmdir
CP = cp
CD = cd
DD = dd
RM = rm

ASM		= nasm
CC		= gcc
LD		= ld
OBJCOPY	= objcopy

ASMBFLAGS	= -f elf -w-orphan-labels
CFLAGS		= -c -Os -std=c99 -m32 -Wall -Wshadow -W -Wconversion -Wno-sign-conversion  -fno-stack-protector -fomit-frame-pointer -fno-builtin -fno-common  -ffreestanding  -Wno-unused-parameter -Wunused-variable
LDFLAGS		= -s -static -T hello.lds -n -Map ShuangOS.map 
OJCYFLAGS	= -S -O binary

SHUANGOS_OBJS :=
SHUANGOS_OBJS += entry.o main.o vgastr.o
SHUANGOS_ELF = ShuangOS.elf
SHUANGOS_BIN = ShuangOS.bin

.PHONY : build clean all link bin

all: clean build link bin

clean:
	$(RM) -f *.o *.bin *.elf

build: $(SHUANGOS_OBJS)

link: $(SHUANGOS_ELF)
$(SHUANGOS_ELF): $(SHUANGOS_OBJS)
	$(LD) $(LDFLAGS) -o $@ $(SHUANGOS_OBJS)
bin: $(SHUANGOS_BIN)
$(SHUANGOS_BIN): $(SHUANGOS_ELF)
	$(OBJCOPY) $(OJCYFLAGS) $< $@

%.o : %.asm
	$(ASM) $(ASMBFLAGS) -o $@ $<
%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<
