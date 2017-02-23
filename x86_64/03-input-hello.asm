
section .data
	question db "What's your name?", 10
	response db "Hello, "

section .bss
	name resb 16

section .text
	global _start

_start:
	call _printQuestion
	call _getName
	call _printResponse

	mov rax, 60
	mov rdi, 0
	syscall

_getName:
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	mov rdx, 16
	syscall
	ret

_printQuestion:
	mov rax, 1
	mov rdi, 1
	mov rsi, question
	mov rdx, 18
	syscall
	ret

_printResponse:
        mov rax, 1
        mov rdi, 1
        mov rsi, response
        mov rdx, 7
        syscall
	mov rax, 1
	mov rdi, 1
	mov rdx, 16
	mov rsi, name
	syscall
        ret
