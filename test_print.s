	section .text
	global _start
	extern print_eax
_start:
	mov eax, 8
	call print_eax
	mov eax, 57
	call print_eax

	mov eax, 1
	mov ebx, 0
	int 0x80
