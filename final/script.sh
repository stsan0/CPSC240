#!/bin/bash

#Program: Harmonic Mean
#Author : Steven Tsan
#Email  : stsan@csu.fullerton.edu
#Section: Section 5

#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Compile control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm

echo "Compile isfloat.cpp"
gcc -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "Compile fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm

echo "Compile harmonic_mean.asm"
nasm -f elf64 -l sum.lis -o harmonic_mean.o harmonic_mean.asm

echo "Compile display.cpp"
gcc -c -Wall -m64 -no-pie -o display.o display.cpp -std=c++17

echo "Link the object files"
gcc -m64 -no-pie -o harmonic_mean.out -std=c++17 main.o control.o isfloat.o fill.o harmonic_mean.o display.o

echo "Run the program:"
./harmonic_mean.out

echo "Delete some un-needed files"
rm *.o
rm *.lis

echo "The script file will terminate"
