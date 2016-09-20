section .text

;in - rdi.
find_word:
	xor rax, rax
	mov rsi, [last_word] 
.loop:
	push rsi
	add rsi, 8
	call string_equals
	test rax, rax
	jnz .return
	pop rsi
	mov rsi, [rsi]
	test rsi, rsi
	jnz .loop
	xor rax, rax
	ret
	.return:
	mov rax, rsi
	pop rsi
	ret
	

native '+', plus
	sub data_top, data_size
	mov r8, [data_top]
	add [data_top - data_size], r8
	ret		

native '-', minus
	sub data_top, data_size
	mov r8, [data_top]
	sub [data_top - data_size], r8
	ret
native '.s', print
	mov r12, data_top
	sub r12, data_size
.loop:
	cmp r12, stack_data
	jb .return
	xor rdi, rdi
	mov rdi, [r12]
	call print_int
	sub r12, data_size
	jmp .loop
.return:
	ret

native 'exit', exit
	mov rax, 60
	xor rdi, rdi
	syscall	


section .data
last_word: dq link	