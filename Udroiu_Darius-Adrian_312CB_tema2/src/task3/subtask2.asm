; write the structures
; struct flight
; 		TODO
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
global filter_flights

; void filter_flights(struct flight* origFlights, struct flight* finalFlights
;						 int* nrFlights, int min_bag_weight)
; rdi = struct flight *origFlights
; rsi = struct flight *finalFlights
; rdx = int *nrFlights
; rcx = int min_bag_weight
filter_flights:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	; salvez pointeru catre nrflights in r14 ca sa nu l pierd
	mov r14, rdx
	; pun in r8 nr total de zboruri
	mov r8d, dword[r14]
	; initializez indexul vectorului cu 0
	mov r9, 0
	; initializez indexul vectorului cerut cu 0
	mov r10, 0
ceva:
	cmp r9, r8
	jge finish
	; inmultesc indexul cu 42
	imul r11, r9, 42
	add r11, rdi

	movzx r12, word[r11+flight.bag_weight]
	cmp r12, rcx
	jl respins
	; inmultesc indexul cu sizeof(struct), adica 42
	imul r12, r10, 42
	add r12, rsi
	; initializez contorul cu 0
	mov r13, 0
copy:
	mov al, byte[r11+r13]
	mov byte[r12+r13], al
	inc r13
	; verifiv daca am copiat 42 bytes
	cmp r13, 42
	jl copy	
	inc r10
respins:
	inc r9
	jmp ceva
finish:
	mov dword[r14], r10d
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

	leave
	ret