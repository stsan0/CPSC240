;*****************************************************************************************************************************
;Program name: "King of Assembly". This program will conduct an interview and give you a job offer                           *
;Copyright (C) 2021 Steven Tsan                                                                                              *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                     *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            *
;*****************************************************************************************************************************

;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Steven Tsan
;  Author email: stsan@csu.fullerton.edu
;
;Program information
;  Program name:  King of Assembly
;  Programming languages:  One file in C++, and One file in X68 Assembly
;  Date program began:     2021-Apr-25
;  Date program completed: 2021-May-07
;  Files in this program:  main.cpp and interview.asm
;  Status: Complete.  No errors found after extensive testing.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;
;Purpose
; To show how to take Char's as input and use them in the program structure
;
;This file
;   File name: interview.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l interview.lis -o interview.o interview.asm
;   Link:     g++ -m64 -no-pie -o interview.out -std=c++17 main.o interview.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper

extern printf
extern scanf

global interview

segment .data
stringFormat db "%s", 0                                                                                       ; format for strings
floatFormat db "%lf", 0                                                                                       ; format for floats
welcomeBlurb db "Hello %s. I am Ms Fenster. The interview will begin now.", 10, 0                           ; welcome message
salaryBlurb db "Wow! $%1.2lf That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?", 10, 0 ; salary message
circuitBlurb db "Alright. Now we will work on your electricity.", 10, 0                                     ; circuit test
circuitQ1 db "Please enter the resistance of circuit #1 in ohms: ", 0                                  ; circuit q1
circuitQ2 db "What is the resistance of circuit #2 in ohms: ", 0                                       ; circuit q2
circuitDone db "The total resistance is %1.3lf Ohms.", 10, 0                                                  ; resistance message
compSciQuestion db "Were you a computer science major (y or n)? ", 0                                          ; CS major question
byeMessage db "Thank you.  Please follow the exit signs to the front desk.", 10, 0                            ; bye message

section .bss

segment .text
interview:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;There are 15 pushes above.  Make one more push of any value so the number of pushes is even
push qword -1                                               ;Now the number of pushes is even
                                                            ;Registers rax, rip, and rsp are not backed up

mov r15, rdi      ; name array
movsd xmm15, xmm0 ; salary moved to xmm15

; welcome message
push qword 0
mov rax, 0
mov rdi, welcomeBlurb
mov rsi, r15
call printf
pop rax

; salary message
push qword 0
mov rax, 1
mov rdi, salaryBlurb
movsd xmm0, xmm15
call printf
pop rax

; question answer y/n
push qword 0
mov rdi, stringFormat
mov rsi, rsp
call scanf
pop rax

mov r14, 'y'
cmp rax, r14
jne ResTest ; If 'y' != answer, goto test

mov rax, 0x412E848000000000 ; Put 1000000.00 into rax
movq xmm14, rax             ; Put 1000000.00 into xmm14
jmp end                     ; Jump to the end

ResTest:
; resistance test
push qword 0
mov rax, 0
mov rdi, circuitBlurb
call printf
pop rax

; first question
push qword 0
mov rax, 0
mov rdi, circuitQ1
call printf
pop rax

; enter first input into xmm10
mov rax, 1
mov rdi, floatFormat
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

; second question
push qword 0
mov rax, 0
mov rdi, circuitQ2
call printf
pop rax

; enter second input into xmm11
mov rax, 1
mov rdi, floatFormat
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

; compute inverse of the resistances
mov r8, 1
cvtsi2sd xmm8, r8
divsd xmm8, xmm10
movsd xmm10, xmm8

cvtsi2sd xmm8, r8
divsd xmm8, xmm11
movsd xmm11, xmm8

; add inverse resistances into xmm13
movsd xmm13, xmm10
addsd xmm13, xmm11

; inverse result to get the resistance
mov r8, 1
cvtsi2sd xmm8, r8
divsd xmm8, xmm13
movsd xmm13, xmm8

; print circuitDone
push qword 0
mov rax, 1
mov rdi, circuitDone
movsd xmm0, xmm13
call printf
pop rax

; ask if CS Major
push qword 0
mov rax, 0
mov rdi, compSciQuestion
call printf
pop rax

; get answer y/n
push qword 0
mov rdi, stringFormat
mov rsi, rsp
call scanf
pop rax

mov r14, 'y'
cmp rax, r14
je csMajor ; if answer != 'y', jump to csMajor

mov rax, 0x4092C07AE147AE14 ;  1200.12 into rax
movq xmm14, rax             ;  1200.12 into xmm14
jmp end                     ; Jump to the end

csMajor:
mov rax, 0x40F57C0E147AE148 ;  88000.88 into rax
movq xmm14, rax             ;  88000.88 into xmm14

end:
; Bye Message
push qword 0
mov rax, 0
mov rdi, byeMessage
call printf
pop rax

;Restore the original values to the general registers before returning to the caller.
pop rax                                                     ;Remove the extra -1 from the stack
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

movsd xmm0, xmm14
ret
