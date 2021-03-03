;Program Name: Quadratic 2. Quadratic formula built using hybrid programming;
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
;  Linux: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm
;

extern printf
extern scanf
extern isfloat
extern show_no_root
extern show_one_root
extern show_two_root
extern Quadlibrary

global Quadratic

segment .data
floatformat db "%lf", 0
stringformat db "%s", 0
welcome db "This Program will find the roots of any Quadratic equation.", 10, 0
prompt db "Please enter the three floating point coefficients of a Quadratic equation in the order a, b, c separated by white spaces.  Then press enter: ", 0
equation db 10, "Thank you. The equation is %1.3lfx^2 + %1.3lfx + %1.3lf = 0.0", 10, 10, 0
invalidstr db 10, "Invalid input data detected.  You may run this program again.", 10 , 10, 0
bye db "One of these roots will be returned to the caller function.", 10, 0

segment .bss

segment .text
;entry
Quadratic:

push rbp
mov rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

push qword 0

;welcome
mov qword rdi, stringformat
mov qword rsi, welcome
mov qword rax, 0
call printf

;prompt
mov qword rdi, stringformat
mov qword rsi, prompt
mov qword rax, 0
call printf

;first input
push qword 0
mov rdi, floatformat
mov rsi, rsp
mov rax, 1
call scanf
movsd xmm10, [rsp]
call isfloat

;convert to float
mov r8, 0
cvtsi2sd xmm8, r8

ucomisd xmm10,xmm8
je invalid
pop rax


;second input
push qword 0
mov rdi, floatformat
mov rsi, rsp
mov rax, 1
call scanf
movsd xmm11, [rsp]
call isfloat

;convert second input to float
ucomisd xmm11,xmm8
je invalid
pop rax

;third input
push qword 0
mov rdi, floatformat
mov rsi, rsp
mov rax, 1
call scanf
movsd xmm12, [rsp]
call isfloat

;convert third input to float
ucomisd xmm12, xmm8
je invalid
pop rax

;print
push qword 0
mov rax, 3
movsd xmm0, xmm10 ; a is xmm10
movsd xmm1, xmm11 ; b is xmm11
movsd xmm2, xmm12 ; c is xmm12
mov rdi, equation
call printf
pop rax

;b^2-4ac
movsd xmm13, xmm11
mulsd xmm13, xmm11
movsd xmm14, xmm12
mulsd xmm14, xmm10
mov r8, 4
cvtsi2sd xmm8, r8
mulsd xmm14, xmm8
subsd xmm13, xmm14

; B^2-4ac compare to 0 to find number of roots

mov r8, 0
cvtsi2sd xmm8, r8
ucomisd xmm8,xmm13

; Set up calculations to find roots
mov r8, -1
cvtsi2sd xmm8, r8
mulsd xmm8, xmm11   ; multiple xmm11 by -1 to get -b  xmm8 is -b
mov r8, 2           ; Put 2 into r8
cvtsi2sd xmm9, r8   ; Call r8 into float
mulsd xmm9, xmm10   ; Multiple xmm10 by 2 to get 2a   xmm10 is a, xmm9 is 2a
sqrtsd xmm13, xmm13 ; Get the square root of xmm13i

; a is xmm10
; b is xmm11
; c is xmm12
movsd xmm14, xmm8  ; Move xmm8 to xmm14     xmm14 holds -b
movsd xmm15, xmm8 ; Move xmm11 to xmm15   - xmm15 holds -b

; Find the first root and store it in xmm14
addsd xmm14, xmm13  ; Add xmm14 and xmm13   xmm13 = discriminant square rooted
divsd xmm14, xmm9   ; divide xmm14 by 2     xmm9 = 2a

; a is xmm10
; b is xmm11
; c is xmm12
; Find the second root and store it in xmm15
subsd xmm15, xmm13  ; Add xmm15 and xmm13   - xmm15 holds -b-sqrt(b^2-4ac)
divsd xmm15, xmm9  ; Divide xmm15 by xmm9 - xmm15 holds 2a-sqrt(b^2-4ac) / 2a

ja zero_root ; if xmm13 below = no root
je one_root ; if xmm13 equal = 1 root
jb two_root ; if xmm13 above = 2 root

; zero root - call show_zero_root
zero_root:
push qword 0
mov rax, 0
call show_no_root
mov r8, 0
cvtsi2sd xmm14, r8
jmp bye_block
pop rax

;one root - call show_one_root
one_root:
push qword 0
mov rax, 1
movsd xmm0, xmm14
call show_one_root
jmp bye_block
pop rax

; Two root - Call show_two_root
two_root:
; Call show_two_root
push qword 0
movsd xmm0, xmm14
movsd xmm1, xmm15
mov rax, 2          ; Signify that there are 2 variables
call show_two_root
jmp bye_block
pop rax

bye_block:
; Goodbye
push qword 0
mov qword rdi, stringformat
mov qword rsi, bye
mov qword rax, 0
call printf
pop rax

jmp end
; Invalid Input
invalid:
push qword 0
mov qword rdi, stringformat
mov qword rsi, invalidstr
mov qword rax, 0
call printf
pop rax

end:
;Restore the original values to the general registers before returning to the caller.
pop rax
pop rax ;extra
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp
movsd xmm0, xmm14
ret
