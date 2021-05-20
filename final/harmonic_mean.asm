; Steven Tsan
; stsan@csu.fullerton.edu
; Section 5

global harmonic_mean

segment .data

segment .text
harmonic_mean:

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

;There are 15 pushes above.  Make one more push of any value so that the number of pushes is an even number
push qword -1                                               ;Now the number of pushes is even
;Registers rax, rip, and rsp are usually not backed up.

; Grab inputs
mov r15, rdi    ;r15 is the array
mov r14, rsi    ;r14 is the array's size
mov r13, 0      ;r13 is loop counter

; Initialize xmm15 to 0
xorpd xmm15, xmm15 ; xmm15 will hold sum

; Sum the preciprocals
beginloop:
cmp r13, r14    ; r13 = count, r14 = size
jge leaveloop   ; Leave loop if end of array

; Put 1 into xmm10
mov r8, 1
cvtsi2sd xmm10, r8

; Get current element, save to xmm11
movsd xmm11, [r15 + 8 * r13]
divsd xmm10, xmm11 ; 1/xmm11 -> xmm10
addsd xmm15, xmm10 ; Add the reciprocal to the sum

inc r13

jmp beginloop ; Restart loop

leaveloop:
cvtsi2sd xmm14, r14 ; Store number of elements into xmm14
divsd xmm14, xmm15  ; Calculate Harmonic Mean
movsd xmm0, xmm14   ; Return Harmonic Mean

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
