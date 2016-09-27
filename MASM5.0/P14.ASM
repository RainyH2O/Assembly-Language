assume cs:code
code segment
time:	db 'yy/mm/dd hh:mm:ss','$'
cmos:	db 9,8,7,4,2,0
start:  mov ax,cs
	mov ds,ax
	mov bx,offset time
	mov si,offset cmos
	mov cx,6
	
s:	push cx
	mov ax,0
	mov al,[si]
	out 70h,al
	in al,71h
	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b
	add ax,3030h
	mov byte ptr [bx],ah
	mov byte ptr [bx].1,al
	add bx,3
	inc si
	pop cx
	loop s

	mov bh,0
	mov dh,12
	mov dl,31
	mov ah,2
	int 10h

	mov dx,offset time
	mov ah,9
	int 21h
	
        mov ax,4c00h
        int 21h

code ends
end start
