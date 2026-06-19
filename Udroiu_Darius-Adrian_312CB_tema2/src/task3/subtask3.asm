; write the structure
; struct flight
;       TODO
; endstruct
struc flight
    .destination: resb 32
    .dep_day: resb 1
    .dep_hour: resb 1
    .dep_min: resb 1
    .arr_day: resb 1
    .arr_hour: resb 1
    .arr_min: resb 1
    .bag_weight: resw 1
    .delayMinutes: resb 1
    .delayHours: resb 1
endstruc

section .text

;; DO NOT MODIFY
global sort_and_return

; int sort_and_return(struct flight* flights, int nrFlights, 
;                      struct flight* bestFlight, char destination[32])
; rdi = flights (pointer)
; rsi = nrFlights (value)
; rdx = bestFlight (pointer to pre-allocated struct)
; rcx = destination (pointer to 32-byte string)
sort_and_return:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    ;; DO NOT MODIFY
    ;; Your code starts here
    ; salvez catre bestFlight in r14
    mov r14, rdx
    ; salvez pointerul catre destination in r15
    mov r15, rcx
    mov r8, rsi
    dec r8
    test r8, r8
    jle find
    ; fac indexul i egal cu 0
    mov r9, 0
while1:
    cmp r9, r8
    jge find
    ; fac indexul j egal cu 0
    mov r10, 0
    mov r11, r8
    sub r11, r9
while2:
    cmp r10, r11
    jge urm
    ; inmultesc cu sizeof(struct), adica 42
    imul r12, r10, 42
    add r12, rdi
    ;adun 42 pt zborul urmator
    lea r13, [r12+42]
    mov al, byte[r12+flight.arr_day]
    cmp al, byte[r13+flight.arr_day]
    jg swap
    jl nswap
    mov al, byte[r12+flight.arr_hour]
    cmp al, byte[r13+flight.arr_hour]
    jg swap
    jl nswap
    mov al, byte[r12+flight.arr_min]
    cmp al, byte[r13+flight.arr_min]
    jg swap
    jl nswap
    ; citesc 2 bytes pt greutate si compar
    mov ax, word[r12+flight.bag_weight]
    cmp ax, word[r13+flight.bag_weight]
    jl swap
    jmp nswap
swap:
    ; fac contorul de swap egal cu 0
    mov rbx, 0
while3:
    mov al, byte[r12+rbx]
    mov cl, byte[r13+rbx]
    mov byte[r12+rbx], cl
    mov byte[r13+rbx], al
    inc rbx
    ; compar cu 42 sa vad daca nu depaseste sizeof(struct)
    cmp rbx, 42
    jl while3
nswap:
    inc r10
    jmp while2
urm:
    inc r9
    jmp while1
find:
    ; fac indexul de cautare egal cu 0
    mov r9, 0
swhile1:
    cmp r9, rsi
    jge nfind
    ; inmultesc indexul cu 42 ca sa ajung la zborul curent
    imul r12, r9, 42
    add r12, rdi
    ; fac indexul pt sirul de caractere egal cu 0
    mov r10, 0
strcmp:
    mov al, byte[r12+flight.destination+r10]
    mov bl, byte[r15+r10]
    cmp al, bl
    jne urmfind
    test al, al
    jz gasit
    inc r10
    jmp strcmp
urmfind:
    inc r9
    jmp swhile1
gasit:
    ; fac indexul pt copiere egal cu 0
    mov r10, 0
copy:
    mov al, byte[r12+r10]
    mov byte[r14+r10], al
    inc r10
    ; vad da am copiat cei 42 de biti
    cmp r10, 42
    jl copy
    ; am reusit
    mov rax, 1
    mov rdx, r14
    jmp fi
nfind:
    ; n am reusit :(
    mov rax, 0
    ; 0 pt struct
    mov rdx, 0
fi:
    ;; Your code ends here
    ;; DO NOT MODIFY
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
    ;; DO NOT MODIFY