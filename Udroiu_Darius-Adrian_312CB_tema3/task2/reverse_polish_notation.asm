section .note.GNU-stack

section .data
	; 0 e terminator de sir
	citire  db "%s", 0
	; 10 e codul ascii pt newline, iar 0 este terminatorul de sir
    afisare db "%lld", 10, 0

section .bss
	; 64 este dim. maxima aloacata pt bufferul sirului de intrare
	buff resb 64

section .text

global reverse_polish_notation
extern scanf
extern printf

reverse_polish_notation:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the reverse_polish_notation function
	push r12
citim:
	mov r12, rsp
	; aliniem stiva la 16 octeti
	and rsp, -16
	mov rdi, citire
	mov rsi,buff
	xor rax,rax 
	call scanf
	mov rsp, r12
	; verificam daca am citit un element
	cmp eax,1
	jne end
	mov rbx,buff
	movzx rdx,byte[rbx]
	cmp dl, '+'
	je adunam
	cmp dl,'*'
	je inmultim
	cmp dl, '/'
	je impartim
	cmp dl,'-'
	je e_minus

idk:
	xor rax, rax
	xor rcx,rcx
	; 1 indica ca are semn pozitiv un numar
	mov r8,1
	movzx rdx,byte[rbx]
	cmp dl,'-'
	jne while
	; -1 indica ca are semn negativ un numar
	mov r8,-1
	inc rcx
while:
	movzx rdx, byte[rbx+rcx]
	test dl,dl
	jz is_ok
	sub rdx, '0'
	; cream numarul
	imul rax,10
	add rax,rdx
	inc rcx
	jmp while
is_ok:
	imul rax, r8
	push rax
	jmp citim
e_minus:
	; verificam daca urmatorul caracter este null
	cmp byte[rbx+1],0
	jne idk
	jmp scadem
inmultim:
	pop rdi
	pop rsi
	imul rsi,rdi
	push rsi
	jmp citim	
scadem:
	pop rdi
	pop rsi
	sub rsi,rdi
	push rsi
	jmp citim
adunam:
	pop rdi
	pop rsi
	add rsi,rdi
	push rsi
	jmp citim
impartim:
	pop rdi
	pop rax
	; verificam daca deimpartitul e negativ 
	cmp rax,0
	jl neggativ
	xor rdx,rdx
	jmp impartim2
neggativ:
	; -1 repr. toti bitii setati pe 1, pt extensia de semn
	mov rdx,-1
impartim2:
	idiv rdi
	push rax
	jmp citim
end:
	pop rsi
	mov r12,rsp
	; aliniem stiva la 16 octeti
	and rsp,-16
	mov rdi, afisare
	xor rax,rax
	call printf
	mov rsp, r12
	pop r12

	leave
	ret
