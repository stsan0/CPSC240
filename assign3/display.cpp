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
//Purpose: Tshis program computes the sum of inserted float numbers in an array.
//Base test system: Linux system with Bash shell and openjdk-14-jdk

//This module
//File name: display.cpp
//Compile: g++ -c -m64 -no-pie -Wall -o display.o display.cpp -std=c++17
//This is the display file, a single function that receives the array
//and prints numbers printed in the order they were inputted.
#include <iostream>
#include <iomanip>

extern "C" void display(double array[], long index);

void display(double array[], long index)
{
    for (int i = 0; i < index; ++i)
    {
      std::cout << std::fixed << std::setprecision(8) << array[i] << " " << std::endl;
    }
    std::cout << std::endl;
}