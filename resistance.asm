; Steven Tsan
; CPSC-240-5 Test 1
extern printf
extern scanf

global compute_x86

segment .data:

welcome db "Hope you have a nice evening Mr Holliday! ", 10, 0
stringformat db "%s", 0
floatformat db "%lf", 0
input1prompt db "Enter the resistance numbers of two subcircuits separated by ws and press enter: ", 0
output_received db "These resistances were received: is %5.8lf Ω, %5.8lf Ω, %5.8lf Ω,",10,0
; average length of rectangle = perimeter/4
output_total db "The resistance of the entire circuit is %5.8lf Ω.",10,0
good_bye db "The assembly program will send the total resistance to the main function.",10,0

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

;resistance prompting
mov qword rdi, stringformat
mov qword rsi, input1prompt
mov qword rax, 0
call printf


; insertion for number 1, resistance xmm10
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

; insertion for number 2, resistance xmm11
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

; insertion for number 3, resistance xmm12
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax

; print received
push qword 0
mov rax, 3
mov rdi, output_received
movsd xmm0, xmm10
movsd xmm1, xmm11
movsd xmm2, xmm12
call printf
pop rax

; Get inverse
mov r8, 1
cvtsi2sd xmm8, r8
divsd xmm8, xmm10
movsd xmm10, xmm8

cvtsi2sd xmm8, r8
divsd xmm8, xmm11
movsd xmm11, xmm8

cvtsi2sd xmm8, r8
divsd xmm8, xmm12
movsd xmm12, xmm8

; add inverse resistances together
movsd xmm13, xmm10
addsd xmm13, xmm11
addsd xmm13, xmm12

; inverse result for resistance
mov r8, 1
cvtsi2sd xmm7, r8
divsd xmm7, xmm13
movsd xmm13, xmm7

;output total and goodbye
push qword 0
mov rax, 1
mov rdi, output_total
movsd xmm0, xmm13
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

movsd xmm0, xmm13 ; send total resistance back!
ret
;End
