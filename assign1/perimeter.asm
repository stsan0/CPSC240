;****************************************************************************************************************************
;Program name: "Area of Rectangle".  This program computes total perimeter and average length of side given the width       *
;and height of the rectangle.                                                                                               *
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
; Program name: Area of Rectangle
; Programming Languages: One module in C++ and one in X86
; Date program began: 2021-February-07
; Date of last update: 2021-February-13
;
;Purpose
; Given the width and height of the rectangle compute the total perimeter and the average length of side.
;
;Project information
; Project files: rectangle.cpp perimeter.asm run.sh
; Status: Finished.
;
;
;Translator information
;  Linux: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
extern printf
extern scanf

global compute_x86

segment .data:

welcome db "This program will compute the perimeter and the average side length of a rectangle.", 10, 0
stringformat db "%s", 0
floatformat db "%lf", 0
input1prompt db "Enter the height: ", 0
input2prompt db "Enter the width:  ", 0
; Perimeter is heightx2 + widthx2. first multiply height and width, then add width to height
output_perimeter db "The perimeter is %5.1lf",10,0
; average length of rectangle = perimeter/4
output_length db "The length of the average side is %5.3lf.",10,0
love db "I hope you enjoyed your rectangle.",10,0
good_bye db "The assembly program will send the perimeter to the main function.",10,0

segment .bss

segment .text

; entry point
compute_x86:

;===== Perform standard update of the point into the system stack
push rbp
mov rbp, rsp

;=====  extra backups.  Some of these are unnecessary but we do them anyway
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf
push qword 0

;welcome message
mov  qword rdi, stringformat
mov  qword rsi, welcome
mov qword rax, 0
call printf

; float number 1, height prompting
mov qword rdi, stringformat
mov qword rsi, input1prompt
mov qword rax, 0
call printf


; insertion for height
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

; float number 1, width prompting
mov qword rdi, stringformat
mov qword rsi, input2prompt
mov qword rax, 0
call printf


; insertion for width
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

;===== compute for perimeter.

; Perimeter is height*2 + width*2.
;first multiply height and width individually, then add width to height
movsd xmm12, xmm10  ; height
addsd xmm12, xmm10 ; height + height = height*2
addsd xmm12, xmm11 ; width + width = width*2
addsd xmm12, xmm11 ; xmm12 is now perimeter

; print perimeter
push qword 0
mov rax, 1
mov rdi, output_perimeter
movsd xmm0, xmm12
call printf
pop rax

; compute for average length
; average length of rectangle = perimeter/4
mov r8, 4
movsd xmm13, xmm12
cvtsi2sd xmm14, r8
divsd xmm13, xmm14 ; xmm13 is now average length

;===== print out results and goodbye
; print average length
push qword 0
mov rax, 1
mov rdi, output_length
movsd xmm0, xmm13
call printf
pop rax

;print love
push qword 0
mov qword rdi, stringformat
mov qword rsi, love
call printf
pop rax

; print goodbye
push qword 0
mov qword rdi, stringformat
mov qword rsi, good_bye
call printf
pop rax



;===== Restore original values to integer registers
pop rax
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

movsd xmm0, xmm12
ret
;End
