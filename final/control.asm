; Steven Tsan
; stsan@csu.fullerton.edu
; Section 5

extern printf
extern fill
extern display
extern harmonic_mean

array_size equ 100 ; Max size for the array

global control

segment .data
stringFormat db "%s", 0
numbers db "Thank you.  You entered:", 10, 0
the_hm db "The harmonic mean of these numbers is %1.9lf", 10, 0
exit db "The harmonic mean will be returned to the driver.", 10, 0

section .bss
array: resq 100

segment .text
control:

;Back up the general purpose registers
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

;Make one more push of any value so that the number of pushes is even
push qword -1                                               ;Now even number of pushes
;Registers rax, rip, and rsp are usually not backed up.

; Fill array
mov qword rdi, array      ; Pass array to  fill function
mov qword rsi, array_size ; Pass max size fill function
mov qword rax, 0
call fill           ; Call fill
mov r15, rax        ; Save array size to r15

; Print numbers
mov qword rdi, stringFormat
mov qword rsi, numbers
mov qword rax, 0
call printf

; Display the Array
push qword 0
mov rdi, array  ; Pass array to display
mov rsi, r15    ; Pass array size to display
mov rax, 0
call display    ; Call display
pop rax

; Sum the array
mov rdi, array       ; Pass array to harmonic_mean
mov rsi, r15         ; Pass array size to harmonic_mean
mov rax, 0
call harmonic_mean   ; Call harmonic_mean
movsd xmm15, xmm0    ; Save harmonic mean to xmm15

; Print harmonic mean
push qword 0
mov rax, 1
mov rdi, the_hm
movsd xmm0, xmm15
call printf
pop rax

; Print exit 
mov qword rdi, stringFormat
mov qword rsi, exit
mov qword rax, 0
call printf

; Return values
movsd xmm0, xmm15

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

ret
