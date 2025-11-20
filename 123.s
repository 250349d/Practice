	section .text
	global	_start
_start:
	mov	ebx, 123
	add	ebx, 45
	sub	ebx, 67
	add	ebx, 8
	sub	ebx, 9
	mov	eax, 1
	int	0x80
