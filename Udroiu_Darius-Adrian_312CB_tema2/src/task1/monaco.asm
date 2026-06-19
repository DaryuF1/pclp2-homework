section .text

;; DO NOT MODIFY
global fix_lap_times


fix_lap_times:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    ;; DO NOT MODIFY
    ;; YOUR CODE STARTS HERE
    ; index pt label
    mov r9, 0
    ; numar erorile
    mov r10, 0

solvee:
    ; verific daca la pozitia r9 vectorol rsi e 1
    cmp byte[rsi+r9], 1
    je err
    ; inmultesc indexu cu 4 pt ca sizeof(unsigned int) e 4
    mov eax, dword[rdi+r9*4]
    jmp add_elem

err:
    inc r10
    test r9, r9
    jz fe
    ; scad 1 ca sa aflu elementul de pe prima pozitie
    lea r11, [rdx-1]
    cmp r9, r11
    je le

    ; inmultesc indexu cu 4 pt ca sizeof(unsigned int) e 4
    mov eax, dword[rdi+ r9*4-4]
    ; inmultesc indexu cu 4 pt ca sizeof(unsigned int) e 4
    add eax, dword[rdi + r9*4+4]
    ; imart la 2 cu shift la dreapta
    shr eax, 1
    jmp add_elem

fe:
    ; adaug 4 la rdi ca sa accesez elementul de dupa
    mov eax, dword[rdi+4]
    jmp add_elem

le:
    ; 
    mov eax, dword[rdi + r9*4-4]
    jmp add_elem 

add_elem:
    ; inmultesc indexu cu 4 pt ca sizeof(unsigned int) e 4
    mov dword [rcx + r9*4], eax
    inc r9
    cmp r9, rdx
    jl solvee      

    mov dword [r8], r10d

    ;; YOUR CODE ENDS HERE
    ;; DO NOT MODIFY
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
    ;; DO NOT MODIFY