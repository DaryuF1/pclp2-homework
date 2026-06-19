section .text

;; DO NOT MODIFY
global check_column
global check_row
global check_box

; int check_row(int **array, int size, int rowNr)
; rdi = int **array
; rsi = int size
; rdx = int rowNr
check_row:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here
	mov rax, rsi
	inc rax
	imul rax, rsi
	;impartim la 2 pt suma lui gauss
	shr rax, 1
	mov r12, rax
	; facem produsul cautat cu 1
	mov r13,1
	; facem contorul egal cu 1
	mov rcx,1
calc1:
	imul r13, rcx
	inc rcx
	cmp rcx, rsi
	jle calc1
	; inmultim numarul liniei cu 8
	mov r8, [rdi+rdx*8]
	; facem suma curenta egala cu 0
	mov r9,0
	; facem produsl curent egal cu 1
	mov r10, 1
	; facem indexul coloanei egal cu 0
	mov rcx, 0
while1:
	cmp rcx, rsi
	jge solve1
	; inmultim indexul coloanei cu 4
	mov eax, dword[r8+rcx*4]
	add r9, rax
	imul r10, rax
	inc rcx
	jmp while1
solve1:
	cmp r9,r12
	jne nu_i_bine1
	cmp r10,r13
	jne nu_i_bine1
	; returnam 1 ca am ajuns la sfarsit
	mov rax, 1
	jmp fi1
nu_i_bine1:
	; returnam 0 ca nu e valid
	mov rax,0
fi1:
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

;; DO NOT MODIFY
; int check_column(int **array, int size, int columnNr)
; rdi = int **array
; rsi = int size
; rdx = int columnNr
check_column:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here
	mov rax, rsi
	inc rax
	imul rax,rsi
	; impartim la 2 pt suma lui gauss
	shr rax, 1
	mov r12,rax
	; facem produsul 1
	mov r13,1
	; facem indexul egal cu 1
	mov rcx,1
calc2:
	imul r13, rcx
	inc rcx
	cmp rcx,rsi
	jle calc2
	; facem suma curenta 0
	mov r9,0
	; faecm produsul curent 1
	mov r10,1
	; facem indexul randului 0
	mov rcx,0
while2:
	cmp rcx,rsi
	jge solve2
	; inmultim indexul liniei cu 8
	mov r8,[rdi+rcx*8]
	; inmultim indexul coloanei cu 4
	mov eax, dword[r8+rdx*4]
	add r9,rax
	imul r10,rax
	inc rcx
	jmp while2
solve2:
	cmp r9,r12
	jne nu_i_bine2
	cmp r10,r13
	jne nu_i_bine2
	; returnam 1 ca am ajuns la sfarsit
	mov rax, 1
	jmp fi2
nu_i_bine2:
	; returnam 0 ca nu i bine
	mov rax,0
fi2:



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

;; DO NOT MODIFY
; int check_box(int **array, int size, int boxNr)
; rdi = int **array
; rsi = int size
; rdx = int boxNr
check_box:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here
	mov rax,rsi
	inc rax
	imul rax,rsi
	; impartim la 2 pt suma lui gauss
	shr rax,1
	mov r12,rax
	; facem produsul 1
	mov r13,1
	; facem indexul 1
	mov rcx,1
calc3:
	imul r13,rcx
	inc rcx
	cmp rcx, rsi
	jle calc3
	; verificam daca sizeul e 4
	cmp rsi, 4
	je s4
	;verificam daca sizeul e 9 
	cmp rsi,9
	je s9
	; daca e 16x16
	mov r14,4
	jmp calc4
s4:
	; daca s e 2
	mov r14,2
	jmp calc4
s9:
	; daca s e 3
	mov r14,3
calc4:
	; calculam coordonatele 
	mov rax, rdx
	; facem rdx 0 pt impartire
	mov rdx, 0
	div r14
	mov r15,rax
	imul r15,r14
	mov r8,rdx
	imul r8,r14
	;facem suma egaala cu 0
	mov r9,0
	; facem produsul egal cu 1
	mov r10,1
	; facem indexul liniei egal cu 0
	mov rcx, 0
for_i:
	cmp rcx, r14	
	jge solve3
	mov rax,r15
	add rax,rcx
	; inmultim rax cu 8 ca sa gasim pointerul randukui
	mov r11, [rdi+rax*8]
	; facem indexul coloanei 0
	mov rbx,0
for_j:
	cmp rbx,r14
	jge fi4
	mov rax,r8 
	add rax, rbx
	; inmultim rax cu 4 pt a gasi elementul curent
	mov eax,dword[r11+rax*4]
	add r9, rax
	imul r10,rax
	inc rbx
	jmp for_j
fi4:
	inc rcx
	jmp for_i
solve3:
	cmp r9, r12
	jne nu_i_bine3
	cmp r10,r13
	jne nu_i_bine3
	; returnam 1 ca e bine
	mov rax,1
	jmp okey
nu_i_bine3:
	;altfel returnam 0
	mov rax,0
okey:
	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
