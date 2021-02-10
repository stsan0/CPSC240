#!/bin/bash

#Program: Area of Rectangle
#author: S. Tsan

rm *.o
rm *.out
echo "Compile C++ file rectangle.cpp"
g++ -c -m64 -Wall -no-pie -o rect.o rectangle.cpp -std=c++17

echo "Assemble X86 file from perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo "Link the object files"
g++ -m64 -no-pie -o area.out -std=c++17 rect.o perimeter.o

echo "Execute the program Area of Rectangle"
./area.out
