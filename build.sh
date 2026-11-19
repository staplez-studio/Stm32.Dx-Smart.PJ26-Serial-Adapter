#!/bin/sh
set -e
CC=${CC:-clang}; LD=${LD:-ld.lld}; OBJCOPY=${OBJCOPY:-llvm-objcopy}
F="--target=thumbv7m-none-eabi -mcpu=cortex-m3 -mthumb -Os -ffreestanding -fno-builtin -fno-stack-protector -nostdlib -Wall -Wno-gnu-designator"
for f in start main usb_proto; do $CC $F -c $f.c -o $f.o; done
$LD -T link.ld -o pj26_usb_native.elf start.o main.o usb_proto.o
$OBJCOPY -O binary pj26_usb_native.elf pj26_usb_native.bin
$OBJCOPY -O ihex pj26_usb_native.elf pj26_usb_native.hex
ls -l pj26_usb_native.bin
