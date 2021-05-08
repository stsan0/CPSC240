#!/bin/bash

#Program: King of Assembly
#Author: Steven Tsan

#Delete un-needed files
rm *.o
rm *.out
rm *.lis

echo "compile main.cpp"
g++ -c -Wall -m64 -no-pie -o main.o main.cpp -std=c++17 -g

echo "compile interview.asm"
nasm -f elf64 -l interview.lis -o interview.o interview.asm -g -gdwarf

echo "link the object files"
g++ -m64 -no-pie -o interview.out -std=c++17 main.o interview.o -g

echo "run the program assign3:"
gdb ./interview.out

echo "delete some un-needed files"
rm *.o
rm *.lis

echo "the script file will terminate"
