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
;  Linux: nasm -f elf64 -l control.lis -o control.o control.asm
;
; This file connects the main.c to the main program
; First it will go to fill,
; Second display the individual numbers on display,
; Third receive the sum from Sum and display it
; Fourth return the sum to main.c for safekeeping.
extern printf
extern scanf
extern fill
extern display
extern sum

array_size equ 7  ; Capacity limit for number of elements allowed in array.

global control

segment .data
floatformat db "%lf", 0
stringformat db "%s", 0
welcome db "Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Steven T.",10, 10, 0
; go to fill module
presentnumbers db "The numbers you entered are:", 10, 0
; go to display module
; get sum of the array, put it in a register for presentsum to display
presentsum db "The sum of these values is %1.8f.",10,10,0
backtomain db "The control module will now return the sum to the caller module.",10, 10, 0

segment .bss
  intArray: resq 7  ; Uninitialized array with 100 reserved qwords.

segment .text
;entry
control:

; back up registers and set stack pointer to base pointer
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

push qword -1              ; Extra push to create even number of pushes

; initialize parameters
mov qword r14, 0           ; Reserve register for number of elements in array.
mov qword r13, 0           ; Reserve register for largest value in array.

;welcome
mov qword rdi, stringformat
mov qword rsi, welcome
mov qword rax, 0
call printf

; go to fill module
mov qword rdi, intArray    ; Passes array into rdi register.
mov qword rsi, array_size  ; Passes the max array size into rsi register.
mov qword rax, 0
call fill
mov r14, rax               ; Saves copy of input_array output into r14.

; present numbers prompt
mov qword rdi, stringformat
mov qword rsi, presentnumbers
mov qword rax, 0
call printf

; go to display module
mov qword rdi, intArray   ; Passes the array as first parameter.
mov qword rsi, r14        ; Passes # of elements in the array stored in r14.
push rax
call display


; get the sum from sum module
mov qword rdi, intArray   ; Passes the array as first parameter.
mov qword rsi, r14        ; Passes # of elements in the array stored in r14.
push rax
call sum                  ; Calls sum function
mov r13, rax              ; Saves a copy of the sum functions output to r13.

; present total # of  sum
push qword 0
movsd xmm0, xmm13
mov rax, 1
mov qword rdi, presentsum
call printf

;back to main
mov qword rdi, stringformat
mov qword rsi, backtomain
mov qword rax, 0
call printf


;Restore the original values to the general registers before returning to the caller.
pop rax
pop rax
pop rax
pop rax
movsd xmm0, xmm13                         ; Copies Sum (xmm13) to xmm0.
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

ret
