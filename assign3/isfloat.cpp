/*;Program Name: Quadratic 2. Quadratic formula built using hybrid programming;
; Incorporates calls to modules written in other languages                  ;
; Copyright (C) 2021 Steven Tsan                                            ;
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************
;Author information
; Author name: Steven Tsan
; Author email: stsan@csu.fullerton.edu
;
;Program information
; Program name: Quadratic 2
; Programming Languages:  modules in C, C++ and one in X86
; Date program began: 2021-February-20
; Date of last update: 2021-February-28
;
;Purpose
; Given three variables, ascertain if there is zero, one, or two Quadratic roots.
;
;Project information
; Project files: Quadratic.asm, Second_degree.cpp, isfloat.cpp, Quadlibrary.cpp, run.sh
; Status: Finished.
;
;
;Translator information
;  Linux: g++ -c -m64 -no-pie -Wall -o isfloat.o isfloat.cpp -std=c++17
;*/
#include <iostream>
#include <iomanip>
#include <cstdlib>                      // Header to include atof function in area.asm.
#include <cctype>                      // Header to include isdigit function.

using namespace std;

// Declare and extern function to make it callable by other linked files.
extern "C" bool isfloat(char []);

// Definition of isfloat function.
bool isfloat(char w[])
{
  bool result = true;
 bool onepoint = false;
 int start = 0;
 if (w[0] == '-' || w[0] == '+') start = 1;
 unsigned long int k = start;
 while (!(w[k] == '\0') && result )
 {    if (w[k] == '.' && !onepoint)
            onepoint = true;
      else
            result = result && isdigit(w[k]) ;
      k++;
  }
  return result && onepoint;
}
