; Steven Tsan
; stsan@csu.fullerton.edu
; Section 5

extern scanf
extern printf
extern isfloat
extern atof

global fill

segment .data
start db "Please enter floating point numbers separated by ws. Invalid inputs will be omitted.", 10, "Enter control+D to terminate.", 10, 0
format db "%lf", 0
stringformat db "%s", 0

segment .text
fill:

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
mov r15, rdi ;r15 is the array
mov r14, rsi ;r14 is the max number of elements in the array
mov r13, 0   ;r13 is for loop counter

; Print loop instructions
push qword 0
mov qword rdi, stringformat
mov qword rsi, start
mov qword rax, 0
call printf

jmp beginloop

invalid:
pop rax

; Input loop
beginloop:
cmp r13, r14    ; r13 = count, r14 = max
jge exit        ; Leave loop if array is full

; Get First Input
push qword 0            ; Push qword to make register open
mov rdi, stringformat   ; Put string format into rdi
mov rsi, rsp            ; Point rsi at rsp
mov rax, 1              ; Put 1 into rax to specify 1 string
call scanf              ; Call scanf

; Check for ctrl-D
cdqe            ; Signal in all of rax
cmp rax, -1
je leaveloop    ; Leave the loop because ctrl-D was entered

; Validate First Input
mov rdi, rsp            ; Point rdi at rsp
mov rax, 0              ; Put 0 into rax to allow returned bit
call isfloat            ; Call isfloat
cmp rax, 0              ; If rax is 0, jump to beginning of loop because invalid input
je invalid

; Convert input to float
mov rax, 1              ; Move 1 to rax
call atof               ; call atof

; Put input in the array
movsd xmm15, xmm0               ; Put input to xmm15
movsd [r15 + 8 * r13], xmm15    ; Add input to array
inc r13
pop rax
jmp beginloop                   ; End of loop

; Exit of loop
leaveloop:
pop rax
exit:
pop rax

;Restore the original values to the general registers before returning to the caller.
pop rax                                                     ;Remove the extra -1 from the stack
mov rax, r13                                                ; Copy number of elements to rax
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
