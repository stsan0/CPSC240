//****************************************************************************************************************************
//Program name: "Area of Rectangle".  This program computes total perimeter and average length of side given the width       *
//and height of the rectangle.                                                                                               *
//                                                                                                                           *
//                                                                                                                           *
//This file is part of the software program "Area of Rectangle".                                                             *
//Area of Rectangle is free software: you can redistribute it and/or modify it under the terms of the                        *
//GNU General Public License version 3 as published by the Free Software Foundation.                                         *
//Area of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied    *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Steven Tsan
//  Author email: stsan@csu.fullerton.edu
//Program information
//  Program name: Area of Rectangle
//  Programming languages: One modules in C and one module in X86
//  Date program began: 2021-Feb-06
//  Date of last update: 2021-Feb-13
//  Date of reorganization of comments: 2021-Feb-13
//  Files in this program: rectangle.cpp, perimeter.asm
//  Status: Finished.
//
//Purpose
//  Given the width and height of the rectangle compute the total perimeter and the average length of side.

//
//This file
//   File name: rectangle.cpp
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -std=c11 -no-pie -o rectangle.o rectangle.c
//   Link: gcc -m64 -no-pie -o current.out -std=c11 rectangle.o rectangle.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <iostream>
#include <iomanip>

extern "C" double compute_x86();

int main (int arc, char* argv[])
{
  std::cout << "Welcome to a friendly assembly program by Steven Tsan." << std::endl;

  double perimeter = 0.00;
  perimeter = compute_x86(); // assembly file does actions and then sends perimeter back.
  std::cout << "The main function received the number " << std::setw(4)
            << std::setprecision(2) << std::fixed
            << perimeter << " and has decided to keep it.\n";

  std::cout << "A 0 will be returned to the operating system.\n";
  std::cout << "Have a nice day.\n";
  return 0;
}
