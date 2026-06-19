section .note.GNU-stack

section .data
; 10 e codul ascii pt newline, 0 e terminator de sir 
e1 db "Error: len <= %d", 10, 0
; 10 e codul ascii pt newline, 0 e terminator de sir 
e2 db "The vector is empty", 10, 0
; 0 e terminator de sir
msg1 db "[]", 0
; 0 e terminator de sir
msg2 db "v -> {(", 0
; 0 e terminator de sir
msg3 db "[%d]", 0
; 10 e codul ascii pt newline, 0 e terminator de sir 
msg4 db "), %d, %d}", 10, 0

section .text

extern malloc
extern printf
extern realloc
extern free
global new_vector
global set_element
global get_element
global push_element
global pop_element
global print_vector
global free_vector


;	struct vector {
;		int *arr;
;		int len;
;		int cap;
;	}

new_vector:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the new_vector function
	push rbx
	push r12
	mov r12d,edi
	;push rdi
	; 16 inseamna dimensiunea structurii
	mov rdi, 16
	call malloc
	test rax,rax
	jz nu_i_bn
	mov rbx,rax
	mov edi,r12d
	; 4 repr, sizeof(int), folosit pt a calcula dimentiunae memorii vectorului
	imul edi,4
	call malloc
	test rax,rax
	jz nu_i_bn2
	mov [rbx], rax
	; 8 e offesetul pt len in structul nostru si il facem 0
	mov dword [rbx+8], 0
	; 12 e offsetul pt cap in structura
	mov [rbx+12],r12d
	mov rax,rbx
	jmp end
nu_i_bn2:
	mov rdi,rbx
	call free
nu_i_bn:
	xor rax, rax
end:
	pop r12
	pop rbx
	leave
	ret

set_element:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the set_element function
	; 8 e offsetul pt len in struct
	mov eax, [rdi+8]
	cmp edx,eax
	jge nu_i_bn3
	mov rcx, [rdi]
	; 4 repr. sizeof(int) si il folosim pt index
	mov [rcx+rdx*4],esi
	mov eax,edx
	leave
	ret
nu_i_bn3:
	mov rdi, e1
	mov esi, edx
	xor eax,eax
	call printf
	; -1 este codul de eroare pe care il returnam
	mov eax, -1
	leave
	ret

get_element:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the get_element function
	; 8 e offsetul pt len in strucura vector
	mov eax, [rdi+8]
	cmp esi,eax
	jge nu_i_bn4
	mov rcx,[rdi]
	; 4 este sizeof(int) si il folosim pt index
	mov eax,[rcx+rsi*4]
	leave
	ret
nu_i_bn4:
	mov rdi, e1
	xor eax,eax
	call printf
	; -1 este codul de eroare pe care il returnam
	mov eax,-1
	leave
	ret

push_element:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the push_element function
	push rbx
	push r12
	mov rbx,rdi
	mov r12d,esi
	; 8 e offsetul pt len
	mov eax, [rbx+8]
	; 12 e offsetul pt cap
	mov ecx, [rbx+12]
	cmp eax,ecx
	jne idk
	; shiftam cu 1 la stanga pt a dubla capacitatea
	shl ecx,1
	; 12 e offsetul pt cap
	mov [rbx+12],ecx
	mov rdi, [rbx]
	mov eax,ecx
	; 4 repr. sizeof(int) si il folosim pt a calcula nr de octeti 
	imul eax,4
	mov esi,eax
	call realloc
	mov [rbx],rax
idk:
	; 8 e offsetul pt len
	mov eax,[rbx+8]
	mov rcx,[rbx]
	; 4 repr sizeof(int)
	mov [rcx+rax*4],r12d
	; 8 e offsetul pt len si il crestem cu 1
	add dword [rbx+8],1
	pop r12
	pop rbx
	leave
	ret

pop_element:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the pop_element function
	push rbx
	push r12
	mov rbx, rdi
	; 8 e offsetul pt len
	mov eax,[rbx+8]
	test eax,eax
	jz e_gol
	; scadem lungimea vectorului cu 1
	sub eax,1
	; 8 e offsetul pt len
	mov [rbx+8],eax
	mov rcx, [rbx]
	; 4 repr. sizeof(int) si il folosim pt a ajunge la ultimul element
	mov r12d, [rcx+rax*4]
	; 12 e offsetul pt. cap
	mov ecx, [rbx+12]
	; verificam daca se atinge limita minima a capacitati
	cmp ecx,1
	jle end2
	mov r8d,ecx
	; 1 shifteaza r8d la dreapta pt a face /2 la capacitate
	shr r8d,1
	cmp eax, r8d
	jg end2
	; 12 e offsetul pt cap
	mov [rbx+12],r8d
	mov rdi, [rbx]
	mov eax, r8d
	; 4 repr. sizeof(int) si il folosim pt a calcula dimensiunea noului bloc de memorie
	imul eax,4
	mov esi, eax
	call realloc
	mov [rbx], rax
end2:
	mov eax, r12d
	pop r12
	pop rbx
	leave
	ret
e_gol:
	mov rdi, e2
	xor eax,eax
	call printf
	; -1 este codul de eroare pe care il returnam
	mov eax, -1
	pop r12
	pop rbx
	leave
	ret

print_vector:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the print_vector function
	push rbx
	push r12
	mov rbx, rdi
	mov rdi, msg2
	xor eax,eax
	call printf
	xor r12d, r12d
while1:
	; 8 e offsetul pt len
	cmp r12d, [rbx+8]
	jge while2
	mov rdi, msg3
	mov rax, [rbx]
	; 4 e sizeof(int) si il folosim pt a accesa elementul curent
	mov esi, [rax+r12*4]
	xor eax,eax
	call printf
	; crestem r12d ca sa avansam in loop
	add r12d,1
	jmp while1
while2:
	; 12 e offsetul pt cap
	cmp r12d, [rbx+12]
	jge end3
	mov rdi,msg1
	xor eax,eax
	call printf
	; crestem r12d sa avansam in loop
	add r12d,1
	jmp while2
end3:
	mov rdi,msg4
	; 8 e offfsetul pt len
	mov esi,[rbx+8]
	; 12 e offsetul pt cap
	mov edx,[rbx+12]
	xor eax, eax
	call printf
	pop r12
	pop rbx
	leave
	ret

free_vector:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the free_vector function
	push rbx
	push r12
	mov r12,rdi
	mov rbx, [r12]
	test rbx,rbx
	jz end4
	mov rdi, [rbx]
	call free
	mov rdi, rbx
	call free
	; setam pointerul apelat la null
	mov qword[r12],0
end4:
	pop r12
	pop rbx
	leave
	ret
