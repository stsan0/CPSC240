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
;  Linux: nasm -f elf64 -l sum.lis -o sum.o sum.asm
;
; This file receives each array variable and computes the sum.
extern printf

global sum                             ; Makes function callable from other linked files.

segment .data
stringNumFormat db "The sum of the %ld numbers in this array is %ld.", 10, 0

segment .bss

segment .text

sum:

; Back up all registers to stack and set stack pointer to base pointer
push rbp
mov rbp, rsp
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

push rax                          ; Extra push onto stack to make even # of pushes.

mov qword r15, rdi                      ; Copies array that was passed to r15.
mov qword r14, rsi                      ; Copies number of elements in the array to r14.
mov qword r12, 0                        ; Counter to to iterate through array.
mov qword r13, r12                     ; Sum register to add elements of array to, = to 0.

;start loop
begin_loop:

;compares the counter (r12) to the number of elements in the array (r14).
cmp r12, r14
jge outofloop

;copy into array
; Adds element of array at index of r12 to the Sum of register xmm13.
addsd xmm13, [r15 + 8 * r12]
inc r12                                 ; Increments counter r12 by 1.

;restarts loop
jmp begin_loop

;end loop
outofloop:
; Restores all backed up registers to their original state.
pop rax                                ; Remove extra push of -1 from stack.
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
mov rax, r13

ret
