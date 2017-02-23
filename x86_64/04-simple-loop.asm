section .data
        text db "Looping :)", 10

section .text
        global _start

_start:
	mov r15, 0

_loop:
	cmp r15, 10
	jge _finish

	inc r15

        mov rax, 1
        mov rdi, 1
        mov rsi, text
        mov rdx, 11
        syscall

	jmp _loop

_finish:
        mov rax, 60
        mov rdi, 0
        syscall

