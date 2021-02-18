#!/bin/bash

#Program: CPSC 240-5 Test 1
#author: S. Tsan

rm *.o
rm *.out
echo "Compile C++ file electricity.cpp"
g++ -c -m64 -Wall -no-pie -o elect.o electricity.cpp -std=c++17

echo "Assemble X86 file from resistance.asm"
nasm -f elf64 -l resistance.lis -o resistance.o resistance.asm

echo "Link the object files"
g++ -m64 -no-pie -o calculator.out -std=c++17 elect.o resistance.o

echo "Execute the program Test 1"
./calculator.out
