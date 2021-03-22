;Program Name: "Sum of an Array ". This program computes the sum of inserted float numbers in an array.
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
; Program name: Sum of an Array
; Programming Languages: modules in C, C++ and three in X86
; Date program began: 2021-Mar-02.
; Date of last update: 2021-Mar-21
;
;Purpose
; This program computes the sum of inserted float numbers in an array.
;
;Project information
; Project files: control.asm, display.cpp, fill.asm, main.c, sum.asm, run.sh, atolong.asm
; Status: Finished.
;
;Translator information
;  Linux: nasm -f elf64 -l fill.lis -o fill.o fill.asm
;
; This file receives the user's floating point, stops when hit with cntl+d
;
extern printf
extern scanf
extern atof
extern isfloat

global fill ;makes function callable from other linked files

segment .data
  instruction db "Please enter floating point numbers separated by ws; when finished, press enter followed by cntrl+D.", 10, 0
  invalid db "The last input was invalid and not entered into the array.", 10, 0
  stringFormat db "%s", 0
  floatformat db "%lf", 0

segment .bss

segment .text

fill:

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

push qword 0
push qword -1              ; Extra push to create even number of pushes

; Initialize parameters
mov qword r15, rdi         ; Address of array now saved to r15
mov qword r14, rsi         ; Max number of elements allowed in array go to r14
mov qword r13, 0           ; Set counter to 0 elements in Array

;instruction
mov qword rdi, stringFormat
mov qword rsi, instruction
mov qword rax, 0
call printf

; Start of loop
begin_loop:
    ;scanf function called to get user input
mov qword rdi, floatformat
push qword 0
mov qword rsi, rsp ; stack pointer points to where scanf outputs
mov qword rax, 0
call scanf

    ; tests if control + d entered to finish input into array
cdqe
cmp rax, -1
je end_of_loop    ; if cntrl+d entered, jump to end of loop

; Input validation [not needed, keeping this for later assignments]
;mov qword rax, 0
;mov qword rdi, rsp
;call isfloat
;cmp rax, 0
;je invalid_input

; ASCII to float [not needed since inserting with floatformat instead of string]
;mov qword rax, 1
;mov qword rdi, rsp
;call atof


; copy into array
movsd xmm15, xmm0
movsd [r15 + 8 * r13], xmm15 ; copy user input into array at index of r13
inc r13                  ; inc # counter by 1


; array capacity test
cmp r13, r14
pop r8
je exit ; compare if # of elements = cap, if it does exit the loop

; restart loop
jmp begin_loop

; invalid input [not needed, keeping this for later assignments]
;invalid_input:
;mov rdi,stringFormat
;mov rsi, invalid
;mov rax, 0
;call printf
;pop r8
;jmp begin_loop


; end of loop
end_of_loop:
pop r8 ; pop off stack into any scratch reg

; exit
exit:

; Restore all backed up registers to their original state.
pop rax                                 ; Remove extra push of -1 from stack.
mov qword rax, r13                      ; Copies # of elements in r13 to rax.
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

ret
