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
;  Linux: g++ -c -m64 -Wall -no-pie -o second_degree.o Second_degree.c -std=c++17
;*/
#include <stdio.h>

extern "C" double Quadratic();

int main ()
{
  double one_root = -999;
  printf("Welcome to Root Calculator \nProgrammed by Steven Tsan. \n");
  one_root = Quadratic();
  printf("The main driver received %1.3lf and has decided to keep it.", one_root);
  printf("A 0 will be returned to the operating system.\n Have a nice day.\n");
  return 0;
}
