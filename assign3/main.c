//Program Name: "Sum of an Array ". This program computes the sum of inserted float numbers in an array.                     *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *

//Author information:
//Author: Steven Tsan
//Mail: stsan@csu.fullerton.edu

//Program information:
//Program name: Sum of an Array, 1.0
//Programming language: modules in C, C++ and three in X86
//Files: control.asm, display.cpp, fill.asm, main.c, sum.asm, run.sh, atolong.asm
//Date project began: 2021-Mar-02.
//Date of last update: 2021-Mar.21
//Status: Work In Progress; testing incomplete.
//Purpose: This program computes the sum of inserted float numbers in an array.
//Base test system: Linux system with Bash shell and openjdk-14-jdk

//This module
//File name: main.c
//Compile: g++ -c -m64 -no-pie -Wall -o main.o main.c -std=c++17
//This is the main file, that goes to and receives the sum from control.asm
#include <stdio.h>
extern "C" double control();

int main()
{
  double sum = -999;
  printf("Welcome to High Speed Array Summation by Steven Tsan.\nSoftware Licensed by GNU GPL 3.0 \nVersion 1.0 released on January 28, 2021.");
  sum = control();
  printf("The main has received this number %1.3lf and will keep it.", sum);
  printf("\nThank you for using High Speed Array Software.");
  printf("\nFor system support contact Steven Tsan at fabooshus@gmail.com");
  printf("\nA zero will be returned to the OS.\n");
  return 0;
}
