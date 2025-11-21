	section .text
	global	_start
	extern print_eax
_start:
	mov	eax, 12356
	mov	ebx, 3600
	mov	edx, 0
	div	ebx
	mov	eax, edx
	call	print_eax
	;mov	ecx, 10
	;mul	ecx
	;mov	ecx, eax
	;mov	eax, edx
	;mov	ebx, 60
	;div	ebx
	;mov	ebx, 5
	;mul	ebx
	;add	ecx, eax
	;add	ecx, edx

	mov	eax, 1
	int	0x80
