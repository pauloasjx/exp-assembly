section .data
        text db "Looping :)", 10 ;define bytes tagged as text

section .text
        global _start

_start:
	mov r15, 0 ;set r15 register to zero

_loop:
	cmp r15, 10 ;compare r15 with 10
	jge _finish ;if r15 >= 10 jump to finish label

	inc r15 ;increment r15 (r15++)

        mov rax, 1 ;syscall write operation
        mov rdi, 1 ;output
        mov rsi, text ;set the buffer to text definition
        mov rdx, 11 ;set the size of text buffer
        syscall

	jmp _loop ;jump to label loop

_finish: 
        mov rax, 60 ;syscall exit operation
        mov rdi, 0 ;define error
        syscall

