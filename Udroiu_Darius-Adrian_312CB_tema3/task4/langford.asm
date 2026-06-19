section .note.GNU-stack

section .text

global check_langford
global generate_langford_sequences

check_langford:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the check_langford function
	mov rax,rsi
	; mascam ultimul bit cu 1 pt paritate
	and rax,1
	; verificam daca e impar
	cmp rax,1
	je nu_i_bn
	; facem contorul egal cu 0
	mov r8, 0
for_i:
	cmp r8,rsi
	jge e_ok
	; inmultim cu 4 pt a accesa elementul dword
	mov eax,dword [rdi + r8*4]
	mov r10,rax
	mov rax,rsi
	; impartim lungimea la 2
	shr rax, 1
	; facem contorul egal cu 0
	mov r9, 0
	; facem nr de aparitii egal cu 0
	mov r11,0
	; pozitia primei aparitii o facem -1
	mov rcx,-1
	; pozitia celei de a 2 a aparitie o facem -1
	mov rdx, -1

for_j:
	cmp r9,rsi
	jge find_j
	; inmultim cu 4 pt ca avem dword 
	mov eax,dword [rdi + r9*4]
	cmp rax,r10
	jne next_j
	; incrementam aparitia
	add r11,1
	; daca e prima aparitie
	cmp r11, 1
	jne is_ok
	mov rcx, r9     
	jmp next_j
is_ok:
	mov rdx,r9
next_j:
	; incrementam pozitia
	add r9,1
	jmp for_j
find_j:
	; verificam daca elementul a aparut de 2 ori
	cmp r11,2
	jne nu_i_bn
	mov rax, rdx
	sub rax, rcx
	; scadem 1 pt a calcula nr de elemente dintre cele 2 pozitii
	sub rax,1
	cmp rax, r10
	jne nu_i_bn
	;incrementam indexul   
	add r8,1
	jmp for_i
nu_i_bn:
	; returnam 0
	mov eax, 0
	jmp end
e_ok:
	; returnam 1
	mov eax, 1
end:
	leave
	ret
generate_langford_sequences:
	push rbp
	mov rbp, rsp
	xor rax, rax
	; TODO - write the generate_langford_sequences function
	; luam valoarea lui n pt a verifica restul la 4
	mov eax, edi
	; mascam ultimiii 2 biti cu 3 pt a afla restul impartirii la 4
	and eax,3
	; daca restul e 0 inseamna ca e valid
	cmp eax,0
	je backtracking
	; daca restul e 3 inseamna ca e valid
	cmp eax, 3
	je backtracking
	; altfel inseamna ca sunt o secvente
	mov dword[rsi],0
	; returnam null
	mov eax,0
	jmp end1
backtracking:
	; aici ar trebui sa fie backtrackingul, dar nu am stiut sa l fac :/
	mov dword[rsi],0
	; returnam null
	mov eax,0
end1:
	leave
	ret

; De ce ca sa fie o solutie valida trebuie sa fie de forma 4k sau 4k+3?
; Deci stim ca o secventa Langford de orfin n are lungimea 2n si contine toate numerele de la 1 la n, fiecare aparand de 2 ori
; Deci presupunem ca indexsii sunt de la 1 la 2n.
; Hai acum sa adunam toti indicii:
; Asta inseamna suma de la 1 la 2n, deci aplicam formula lui gauss si reiese, dupa simplificari, ca suma este egala cy n*(2n+1)
; Fie pi, prima pozitie al nr. i si qi a 2a pozitie al acestui numar
; Stim ca trebuie ca intre aceste 2 pozitii sa existe i elemente
; alegem pi < qi: deci qi - pi = i + 1
; acum hai sa facem suma tuturor acestor pozitii, adica suma de la i la n din (pi + qi)
; inlocuind din relatia precedenta obtinemm ca suma pozitiilor este suma de la 1 la n din (2*pi + i +1)
; scargand acum aceasta suma in 3 sume reiese ca suma pozitiilor este:
; 2*(suma de la 1 la n din pi) + suma de la 1 la n din i + suma de la 1 la n din 1
; suma din i este n*(n+1)/2 (gauss), iar suma din 1 este n, deci
; suma_pozitiilor = 2*(suma de la 1 la n din pi) + n*(n+1)/2 + n
; Acum vom egala cele 2 formule obtinute:
; n*(2n+1) = 2*(suma de la 1 la n din pi) + n(n+1)/2 + n
; desfacem parantezele si efectuam simplificarile reiese ca:
; suma de la 1 la n din pi = (3n^2-n)/4
; stiind ca suma pozitiilor trebuie sa fie un numar natural, inseamna ca si numarul (3n^2-n)/4 trebuie sa fie natural
; astfel, n*(3n-1)/4 trebuie sa se imparta la 4
; deci n*(3n-1) este multiplu de 4
; de unde rezulta ca afirmatia este adevarata doar deca n este de forma 4k sau 4k+3, pt. celelalte cazuri se poate lua separat si observa ca nu convin.
; din cauza asta facem and eax, 3 sa vedem restul impartirii la 4