	section 	.text
	global 	sort

sort:
	push 	eax
	push 	edx
	push 	esi
	push 	edi
	push	ebp
	mov	[data1], ebx
	mov	[data2], ecx
	push 	ebx
	push	ecx

	mov	ebp, 0		; ebp を size として扱う
	mov	ecx, [data2]	; データの個数を保存
	add	ecx, 1
	
_if:
	dec	ecx
	cmp	ecx, 0
	je	next_prepare
	
	
push_heap:
	inc	ebp	; size = size + 1
	mov	esi, [ebx + ebp * 4 - 4]
	mov	[data + ebp * 4], esi ; T[size] = x
	mov	eax, ebp	; k = size

push_heap_while:	
	cmp	eax, 1
	jle	_if

	mov	[dataeax], eax
	mov	esi, 2
	mov	edx, 0
	div	esi
	mov	edx, 0
	mov	esi, eax
	mov	eax, [dataeax]	; esi = eax / 2

	mov	edx, [data + esi * 4]
	cmp	[data + eax * 4], edx
	jle	_if		; while ((T[k] > T[k / 2]) && (k > 1))

	mov	[dataeax], eax
	mov	esi, 2
	mov	edx, 0
	div	esi
	mov	edx, 0
	mov	esi, eax
	mov	eax, [dataeax]	; esi = eax / 2

	mov	edx, [data + eax * 4]
	mov	[datasave], edx	; [datasave] = [data + eax * 4]
	mov	edx, [data + esi * 4]
	mov	[data + eax * 4], edx
	mov	edx, [datasave]
	mov	[data + esi * 4], edx ; swap (T[k], T[k / 2])

	mov	esi, 2
	mov	edx, 0
	div	esi
	mov	edx, 0		; k = k / 2
	
	jmp	push_heap_while

next_prepare:
	mov	ebp, [data2]	; ebp = size
	
delete_maximum:
	mov	edx, [data + 4]
	mov	[ebx + ebp * 4 - 4], edx
	mov	edx, [data + ebp * 4]
	mov	[data + 4], edx ; T[1] = T[size]
	dec	ebp			 ; size = size - 1
	jz	end
	mov	eax, 1			 ; eax  = k = 1

delete_maximum_while:
	mov	[dataeax], eax
	mov	esi, 2
	mul	esi
	mov	edx, 0
	mov	esi, eax
	mov	eax, [dataeax]
	cmp	esi, ebp
	jg	delete_maximum		; while (2 * k <= size)

if1:				; 子が１つの場合
	cmp	esi, ebp		
	jne	else1		; if (2 * k == size)

	mov	edx, [data + 8 * eax]
	cmp	[data + 4 * eax], edx
	jge	delete_maximum		; if (T[k] < T[k * 2])

	mov	edx, [data + 8 * eax]
	mov	[datasave], edx	; [datasave] = [data + 8 * eax]
	mov	edx, [data + 4 * eax]
	mov	[data + 8 * eax], edx
	mov	edx, [datasave]
	mov	[data + 4 * eax], edx ; swap (T[k], T[k * 2])

	mov	esi, 2
	mul	esi
	mov	edx, 0		; k = k * 2
	jmp	delete_maximum_while

else1:				; 子が２つの場合

if2_1:
	mov	edx, [data + 8 * eax + 4]
	cmp	[data + 8 * eax], edx
	jle	else2_1		; if (T[2 * k] > T[2 * k + 1])

	mov	[dataeax], eax
	mov	esi, 2
	mul	esi
	mov	edx, 0
	mov	esi, eax
	mov	eax, [dataeax]	; esi = 2 * k
	mov	edi, esi	; big = 2 * k
	jmp	if2_2

else2_1:
	mov	[dataeax], eax
	mov	esi, 2
	mul	esi
	mov	edx, 0
	mov	esi, eax
	add	esi, 1
	mov	eax, [dataeax]
	mov	edi, esi ; big = 2 * k + 1

if2_2:
	mov	edx, [data + 4 * edi]
	cmp	[data + 4 * eax], edx
	jge	delete_maximum	; if (T[k] < T[big])

	mov	edx, [data + 4 * edi]
	mov	[datasave], edx	; [datasave] = [data + 4 * edi]
	mov	edx, [data + 4 * eax]
	mov	[data + 4 * edi], edx
	mov	edx, [datasave]
	mov	[data + 4 * eax], edx ; swap (T[k], T[big])

	mov	eax, edi	; k = big
	jmp	delete_maximum_while
	
end:	
	pop	ecx
	pop	ebx
	pop	ebp
	pop	edi
	pop	esi
	pop	edx
	pop	eax

	ret
	
	section 	.data
datasave:	times	1	dd	0 ; data の保存地
dataeax:	times	1	dd	0 ; eax の保存地
data1:	times 	1	dd	0	; データの先頭番地
data2:	times	1	dd	0	; データの個数
data3:	times	1	dd	0	; ２分木の何番目に入れたか
data:	times	300001	dd	0
ndata:	equ	($ - data) / 4
	
