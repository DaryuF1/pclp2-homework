section .note.GNU-stack

section .text

global my_printf
extern stdout
extern putc

my_printf:
    push rbp
    mov rbp, rsp
    xor rax, rax
    ; TODO - write the my_printf function
    push rbx
    push r12
    push r13
    push r14
    push r15
    push r9
    push r8
    push rcx
    push rdx
    push rsi
    mov r15,rdi
	; adresa primului argument de pe stiva este la -80
    lea r14,[rbp-80]
	; fac contorul egal cu 0
    mov r12,0
while:
    movzx rcx, byte[r15]
    test cl,cl
    jz end
    cmp cl, '%'
    je find1
print_normal:
    mov rdi,rcx
    mov rsi, [stdout]
    call putc
	; incrementare nr de caractere printate cu 1
    add r12, 1
	; avansam pointeru in string
    add r15,1
    jmp while
find1:
	; sarim peste caracterul %
    add r15,1
    movzx rcx,byte[r15]
    cmp cl, 'c'
    je este_c
    cmp cl, 's'
    je este_s
    cmp cl, 'l'
    je e_lu
print_ce_ramane:
    mov rdi,rcx
    mov rsi, [stdout]
    call putc
	; incrementam nr de caractere printate
    add r12, 1
	; avansam pointeru in sttring
    add r15,1
    jmp while
e_lu:
	; sarim peste litera l
    add r15,1
    movzx rcx,byte[r15]
    cmp cl, 'u'
    je este_lu
	; sarim peste caracterul invaliud
    add r15,1
    jmp while
este_c:
    mov rax, [r14]
	; trecem la urmatorul argument
    add r14, 8
	; incaracam limita argumentelor salvate
    lea r10, [rbp-40]
    cmp r14, r10
    jne sari_c
	; sarim la argumentele de pe stiva aflate la rbp + 16
    lea r14, [rbp+16]
sari_c:
    mov rdi, rax
    mov rsi,[stdout]
    call putc
	; incrementam nr. de caractere afisat
    add r12, 1
	; avansam pointeru in string
    add r15, 1
    jmp while
este_s:
    mov r13,[r14]
	; trecem la urmatorul argument
    add r14,8
	; incarcam limita argumentelor salvate la rbp -40
    lea r10, [rbp-40]
    cmp r14, r10
    jne sari_s
	; sarim la argumentele de pe stiva aflate la rbp +16
    lea r14, [rbp+16]
sari_s:
while1:
    movzx rcx,byte[r13]
    test cl,cl
    jz end_s
    mov rdi,rcx
    mov rsi, [stdout]
    call putc
	; incrementam nr de caractere afisat
    add r12, 1
	; avansam pointeru in string
    add r13, 1
    jmp while1
end_s:
	; trecem peste specificator
    add r15,1
    jmp while
este_lu:
    mov rax, [r14]
	; trecem la urmatorul argument
    add r14,8
	; incarcam limita argumentrlor aflate la rbp -40
    lea r10, [rbp-40]
    cmp r14, r10
    jne sari_lu
	; sarim la argumentele de pe stiva aflate la rbp +16
    lea r14, [rbp+16]
sari_lu:
    mov rbx,rsp
	; pt. a extrage cifrele folosim %10
    mov rcx,10
while2:
	; facem partea superioara a deimpartitului egal cu 0
    mov rdx, 0
    div rcx
    add rdx, '0'
	; ne facem spatiu pe stiva
    sub rsp, 1
    mov [rsp],dl
    test rax, rax
    jnz while2
while3:
    cmp rsp, rbx
    je end_lu
    movzx rdi,byte[rsp]
	; eliberam spatiul cifrei de pe stiva
    add rsp, 1
    mov r13,rsp
	; aliniam stiva
    and rsp, -16
    mov rsi, [stdout]
    call putc
    mov rsp, r13
	; incrementam nr de caractere afisate
    add r12, 1
    jmp while3
end_lu:
	; trecem peste specificator
    add r15, 1
    jmp while
end:
    mov rax, r12
	; trecem peste cele 5 argumente si restauram rsp
    lea rsp, [rbp-40]
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp

    ;leave
    ret