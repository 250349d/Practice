        section .text
        global  _start
        extern  sort, print_eax
_start:	

	mov	ebp, 1000
	
	mov	ebx, 5
	mov	ecx, 299995
	
loop111:
	mov	eax, [data1 + 4	* ebx - 12]
	add	[data1 + 4 * ebx], eax
	mov	eax, [data1 + 4	* ebx - 20]
	add	[data1 + 4 * ebx], eax
	mov	eax, [data1 + 4	* ebx - 8]
	add	[data1 + 4 * ebx], eax

	mov	eax, [data1 + 4 * ebx]

	div	ebp

	mov	[data1 + 4 * ebx], edx
	mov	edx, 0

	inc	ebx
	dec	ecx
	jnz	loop111

	mov	eax, [data1 + 12]
	div	ebp
	mov	[data1 + 12], edx
	mov	edx, 0

	mov	eax, [data1 + 16]
	div	ebp
	mov	[data1 + 16], edx
	mov	edx, 0
	
        mov     ebx, data1      ; データの先頭番地
        mov     ecx, ndata1     ; ダブルワードの個数

	;; 計測開始
        call    sort            ; 昇順に整列
	mov	esi, 300000
	mov	ebp, 0
loop2:	
        mov     eax, [data1 + ebp * 4]    ; 先頭=最小値
        call    print_eax

	inc	ebp
	cmp	ebp, 300000
	jne	loop2
        mov     eax, 1
        mov     ebx, 0
        int     0x80            ; exit

        section .data
dataeax:	dd 0
data1:	dd 1, 22, 333, 4444, 55555
	times 299995 dd 0	;300000個の乱数を保存するための領域を確保
ndata1: equ     ($ - data1)/4    ; ダブルワードの個数(=バイト数/4)
