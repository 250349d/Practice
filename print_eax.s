	;; N という名前の名前付き定数を定義し，N の値を10進数で標準出力に出力するアセンブリ言語プログラム

	section .text
	global print_eax

ndigit:	equ 32			; 桁数
	
print_eax:
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp

	mov ebp, eax
	push eax

	mov eax, ebp

	mov ebp, 10		; 割る数として定義
	mov ecx, buf + ndigit	; 作業領域の末尾の次の番地
	mov edi, 0		; 文字列の長さをカウント

_loop:
	add edi, 1		; edi = edi + 1, 桁数に 1 を加える
	mov bl, '0'		; ０の文字コード
	
	mov edx, 0	        ; 割るので，edx を 0 にリセット
	div ebp	         	; edx:eax / 10 = eax, edx:eax % 10 = edx

	add bl, dl		; bl = '0' + 余り
	
	dec ecx			; 次の書き込み先
	mov [ecx], bl		; 作業領域に１文字書き込む
	cmp eax, 0		; if (eax == 0) { jmp _write }
	je _write		; すべての桁数を書き込んだならば write で出力する
	jmp _loop		; else { jmp _loop }

_write:
	add edi, 1		; 文字列の長さに改行を含める
	
	mov eax, 4		; write のシステムコール番号
	mov ebx, 1		; 出力先番号
	mov edx, edi		; 改行を含めた文字列の長さ
	int 0x80
	
	;; 	mov eax, 1	mov ebx, 0	int 0x80

	pop eax
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx

	ret

	section .data
	
buf:	times ndigit db 0
	db 0x0a
