
section .data
	text db "Hello World", 10 ;define bytes as text with content Hello World - 10 means \n

section .text
	global _start

_start:
	mov rax, 1 ;syscall write operation
	mov rdi, 1 ;output
	mov rsi, text ;buffer
	mov rdx, 14 ;size of the buffer
	syscall

	mov rax, 60 ;syscall exit operation
	mov rdi, 0 ;errors
	syscall
