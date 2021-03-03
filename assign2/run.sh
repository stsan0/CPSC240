#!/bin/bash

#Program: Quadratic 2
#author: S. Tsan
rm *.o
rm *.out
echo "compile second degree"
g++ -c -m64 -Wall -no-pie -o second_degree.o Second_degree.c -std=c++17

echo "assemble quadratic"
nasm -f elf64 -l quadratic.lis -o quadratic.o Quadratic.asm

echo "compile isfloat"
g++ -c -m64 -no-pie -Wall -o isfloat.o isfloat.cpp -std=c++17

echo "compile quadlibrary"
g++ -c -m64 -Wall -no-pie -o quadlibrary.o Quadlibrary.cpp -std=c++17

echo "link object files"
g++ -m64 -no-pie -o quad.out -std=c++17 second_degree.o quadratic.o isfloat.o quadlibrary.o

echo "execute"
./quad.out

rm *.o
rm *.lis
