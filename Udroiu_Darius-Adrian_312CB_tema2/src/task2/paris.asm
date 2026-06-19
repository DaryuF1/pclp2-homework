section .text

;; DO NOT MODIFY
global solve_labyrinth

solve_labyrinth:
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    r12
    push    r13
    push    r14
    push    r15

    mov     r12, rdi
    mov     r13, rsi
    mov     r14, rdx
    mov     r15, rcx
    mov     rbx, r8
    ;; DO NOT MODIFY
    ;; YOUR CODE STARTS HERE

    ; fac linia curenta 0
    mov r8, 0
    ; fac coloana curenta 0
    mov r9, 0
    ; calculez unde se afla ultima linie
    lea r10, [r14-1]
    ; calculez unde se afla ultima coloana
    lea r11, [r15-1]

idkk:
    cmp r8, r10
    je finish
    cmp r9, r11
    je finish
    ;inmultesc indexul liniei sa fac rost de adresa acesteia
    mov rcx, [rbx + r8*8]
    ; fac celula curenta egala cu 0
    mov byte [rcx + r9], '1'

jos:
    ; inmultesc cu 8 si mai adun 8 ca sa fac rost de adresa liniei de sub linia unde ma aflu
    mov rcx, [rbx + r8*8+8]
    cmp byte[rcx+r9], '0'
    jne sus
    inc r8
    jmp idkk

sus:
    test r8,r8
    jz stanga
    ; inmultesc cu 8 si mai scad 8 ca sa fac rost de adresa liniei de deasupra linia unde ma aflu
    mov rcx, [rbx + r8*8-8]
    cmp byte[rcx+r9], '0'
    jne stanga
    dec r8
    jmp idkk

stanga:
    test r9,r9
    jz dreapta
    ; inmultesc indexul liniei cu 8 sa aflu adresa liniei curente
    mov rcx, [rbx+r8*8]
    ; scad 1 din indexul coloanei sa verific daca e 0
    cmp byte[rcx+r9-1], '0'
    jne dreapta
    dec r9
    jmp idkk

dreapta:
    ; inmultesc indexul liniei cu 8 sa aflu adresa liniei curente
    mov rcx, [rbx+r8*8]
    ; adun 1 din indexul coloanei sa verific daca e 0
    cmp byte[rcx+r9+1], '0'
    jne idkk
    inc r9
    jmp idkk

finish:
    mov dword[r12],r8d
    mov dword[r13],r9d

    ;; YOUR CODE ENDS HERE
    ;; DO NOT MODIFY
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
    ;; DO NOT MODIFY