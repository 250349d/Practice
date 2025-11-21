	section .text
	global _start
	extern print_eax
_start:
	mov eax, 0xffff
	call print_eax
	mul eax
	call print_eax

	mov eax, 1
	mov ebx, 0
	int 0x80
