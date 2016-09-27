assume cs:codesg
data segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'

        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw 11542,14430,15257,17800

	db 10000 dup (0)
data ends

table segment
        db 10000 dup (0)
table ends

codesg segment
start:  mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
	mov bx,0
	mov di,0
	mov cx,21
	
	mov si,210
	mov bx,0
	mov cx,21
s0:	mov ax,[bx]
	mov [si],ax
	mov ax,[bx].2
	mov [si].2,ax
	mov byte ptr [si].4,0
	add bx,4
	add si,5
	loop s0

	mov bx,0
	mov cx,21
s1:	mov ax,84[bx]
	mov dx,86[bx]
	call dtoc
	add bx,4
	loop s1
	
	mov bx,0
	mov cx,21
s2:	mov ax,168[bx]
	mov dx,0
	call dtoc
	add bx,2
	loop s2
	
	mov bx,0
	mov cx,21
s3:	push cx
	mov ax,84[bx]
	mov dx,86[bx]
	mov cx,168[di]
	call divdw
	call dtoc
	add bx,4
	add di,2
	pop cx
	loop s3
	
	mov dl,0
	mov si,210
	mov cx,4
s5:	push cx
	mov dh,4
	mov cx,21
s4:	push cx
	mov cl,2
	call show_str
	inc dh
	inc si
	pop cx
	loop s4
	add dl,10
	pop cx
	loop s5
	
	mov ax,4c00h
	int 21h

dtoc:	push cx
	push di
	
	mov di,0
d0:	mov cx,10
	call divdw
	inc di
	add cx,30h
	push cx
	mov cx,dx
	jcxz d1
	jmp d0
d1:	mov cx,ax
	jcxz d2
	jmp d0
d2:	mov cx,di
d3:	pop ax
	mov [si],al
	inc si
	loop d3
	mov byte ptr [si],0
	inc si
	
	pop di
	pop cx
	ret

divdw:	push bx
	
	push ax
	mov ax,dx
	mov dx,0
	div cx
	mov bx,ax
	pop ax
	div cx
	mov cx,dx
	mov dx,bx
	
	pop bx
	ret

show_str:	push ax
		push es
		push bx

		mov ax,0B800h
		mov es,ax
		mov ax,160
		mul dh
		mov bx,ax
		mov ax,2
		mul dl
		add bx,ax
		mov al,cl
		
show:		mov ch,0
		mov cl,[si]
		jcxz ok
		mov es:[bx],cl
		mov es:[bx].1,al
		inc si
		add bx,2
		jmp show 
		
ok:		pop bx
		pop es
		pop ax
		ret
		
codesg ends
end start
