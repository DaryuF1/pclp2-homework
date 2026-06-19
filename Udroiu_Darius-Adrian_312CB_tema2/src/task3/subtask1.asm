; write the structures. make sure it fits the layour in the README
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
global apply_delay
; void apply_delay(struct flight* flights, int nrFlights)
; rdi = struct flight *flightss
; rsi = int nrFlights
apply_delay:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here
	mov r8, rdi
	mov rcx, rsi
nj:
	movzx r9, byte[r8+flight.delayMinutes]
	movzx r10, byte[r8+flight.delayHours]
	movzx r11, byte[r8+flight.dep_min]
	add r11, r9
	mov r12, r10
calc1:
	; vad daca r11 depaseste 60 de minute
	cmp r11, 60
	jl calc1_next
	; daca depaseste scad minutele in plus si incrementez r12, reprezentand ora
	sub r11, 60
	inc r12
	jmp calc1
calc1_next:
	mov byte[r8+flight.dep_min], r11b
	movzx r11, byte[r8 + flight.dep_hour]
	add r11, r12
	; resetez r12 la 0
	mov r12, 0
calc2:
	; vad daca r11 depaseste 24 de ore
	cmp r11, 24
	jl calc2_next
	; daca depaseste scad din el 24 si incrementez r12, reprezentand zilele
	sub r11, 24
	inc r12
	jmp calc2
calc2_next:
	mov byte[r8+ flight.dep_hour], r11b
	movzx r11, byte[r8 +flight.dep_day]
	add r11, r12
	mov byte[r8+flight.dep_day], r11b
	movzx r11,byte [r8+flight.arr_min]
	add r11, r9           
	mov r12, r10

calc3:
	; vad daca r11 depaseste 60 de minute
	cmp r11, 60
	jl calc3_next
	; daca depaseste scad minutele in plus si incrementez r12, reprezentand ora
	sub r11, 60
	inc r12
	jmp calc3
calc3_next:
	mov byte[r8 + flight.arr_min], r11b
	movzx	r11, byte[r8+flight.arr_hour]
	add r11,r12
	; resetez r12 la 0
	mov r12, 0
calc4:
	; vad daca r11 depaseste 24 de ore
	cmp r11, 24
	jl calc4_next
	; daca depaseste scad din el 24 si incrementez r12, reprezentand zilele
	sub r11, 24
	inc r12
	jmp calc4
calc4_next:
	mov byte[r8+flight.arr_hour],r11b
	movzx r11, byte[r8+flight.arr_day]
	add r11,r12  
	mov byte[r8+flight.arr_day],r11b
	; adaug la r8 sizeof(struct) ca sa trec la urmatorul element
	add r8, 42           
	dec rcx 
	jnz nj




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
