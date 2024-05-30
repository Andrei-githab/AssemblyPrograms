#! /bin/bash

nasm -f elf -g -F dwarf lab7s.asm
ld -m elf_i386 -g -o lab7s.out lab7s.o