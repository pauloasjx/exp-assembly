
section .data
	text db "Hello World!", 10 ;define bytes with the message Hello World!\n

section .text
	global _start

_start:
	call _print ;call print block

	mov rax, 60 ;syscall exit operation
	mov rdi, 0 ;errors
	syscall

_print:
	mov rax, 1 ;syscall write operation
	mov rdi, 1 ;output argument
	mov rsi, text ;output buffer
	mov rdx, 14 ;buffer size
	syscall
	ret ;return
