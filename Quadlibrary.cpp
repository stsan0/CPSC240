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
;  Linux: g++ -m64 -no-pie -o quad.out -std=c++17 second_degree.o quadratic.o isfloat.o quadlibrary.o
;*/
#include <iostream>
#include <iomanip>
#include <cmath> //

extern "C" double Quadlibrary(double []);

extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);

double Quadlibrary(double v[]){
  double a,b,c = 0;
  // I ultimately don't use these equations but they helped in comparisons to .asm
  double x1, x2, discriminant;
  a = v[0]; // declaring variables a, b, and c equal to quadratic input
  b = v[1];
  c = v[2];
  // quadratic equation is -b plus or minus sqrt(b^2-4ac), all divided by 2a.
  // b^(2)-4ac is the discriminant.
    // if discriminant > 0, 2 roots found by quadratic equation
    // if  = 0, 1 root. root is = -b/2a
    discriminant = b*b - 4*a*c;
    if (discriminant > 0){
        x1 = (-b + sqrt(discriminant)) / (2*a);
        x2 = (-b - sqrt(discriminant)) / (2*a);
        //std::cout << "Roots are real and different." << endl;
        //std::cout << "x1 = " << x1 << endl;
        //std::cout << "x2 = " << x2 << endl;
        show_two_root(x1,x2);
        return x1;
    }
    else if (discriminant == 0) {
        //std::cout << "Roots are real and same." << endl;
        x1 = -b/(2*a);
        show_one_root(x1);
        return x1;
    }
    else if (discriminant < 0){
      //If the discriminant of a quadratic function is less than zero,
      // that function has no real roots,
      show_no_root();
    }
    return 0;
}


void show_no_root(){
  std::cout << "There are no roots to display.\n";
}

void show_one_root(double root){
  std::cout << std::fixed <<std::setprecision(5) << "The root is " << root << std::endl;
}

void show_two_root(double root1, double root2){
  std::cout << std::fixed <<std::setprecision(5) <<"The roots are " << root1 << " and " << root2 << std::endl;
}
