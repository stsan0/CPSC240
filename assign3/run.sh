#!/bin/bash

#Program: Sum of an Array
#author: S. Tsan
rm *.o
rm *.out
echo "compile main"
g++ -c -m64 -Wall -no-pie -o main.o main.c -std=c++17

echo "assemble control"
nasm -f elf64 -l control.lis -o control.o control.asm

echo "assemble fill"
nasm -f elf64 -l fill.lis -o fill.o fill.asm

echo "assemble sum"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "compile display"
g++ -c -m64 -Wall -no-pie -o display.o display.cpp -std=c++17

echo "link object files"
g++ -m64 -no-pie -o arraysum.out -std=c++17 main.o control.o fill.o sum.o display.o

echo "execute the program"
./arraysum.out

rm *.o
rm *.out
