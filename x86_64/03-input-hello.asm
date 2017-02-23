
section .data
	question db "What's your name?", 10 ;define bytes with text What's your name?\n
	response db "Hello, " ;define bytes with text Hello, 

section .bss
	name resb 16 ;aloc a num of bytes

section .text
	global _start

_start:
	call _printQuestion ;call printQuestion block
	call _getName ;call getName block
	call _printResponse ;call printResponse block

	mov rax, 60 ;syscall exit operation
	mov rdi, 0 ;errors argument
	syscall

_getName: ;getName block
	mov rax, 0 ;syscall read operation
	mov rdi, 0 ;input arg
	mov rsi, name ;buffer
	mov rdx, 16 ;size of the buffer
	syscall
	ret ;return

_printQuestion:
	mov rax, 1 ;syscall write operation
	mov rdi, 1 ;output arg
	mov rsi, question ;buffer
	mov rdx, 18 ;size of the buffer
	syscall
	ret ;return

_printResponse:
        mov rax, 1 ;syscall write operation
        mov rdi, 1 ;output arg
        mov rsi, response ;buffer
        mov rdx, 7 ;size of the buffer
        syscall
	mov rax, 1 ;syscall write operation
	mov rdi, 1 ;output arg
	mov rdx, 16 ;size of the buffer
	mov rsi, name ;buffer
	syscall
        ret ;return
