assume cs:code
table segment
        db '1) reset pc',0
        db '2) strat system',0
        db '3) clock',0
        db '4) set clock',0
table ends

data segment
        db 64 dup (0)
data ends

code segment
a	dw sub1,sub2,sub3,sub4
time	db 'yy/mm/dd hh:mm:ss'
cmos	db 9,8,7,4,2,0
addres	dw 0,0
start:  call showop

getstr:	mov ah,0
	int 16h

	sub al,31h
	cmp al,0
	jb getstr
	cmp al,3
	ja getstr
	mov bl,al
	mov bh,0
	add bx,bx
	call word ptr a[bx]
	
	mov ax,4c00h
	int 21h

showop:	call clear
	push ax
	push bx
	push cx
	push si
	push di
	push ds
	push es

	mov ax,table
        mov es,ax
	mov di,0
	
        mov ax,data
        mov ds,ax
        mov si,0
	
	mov cx,4
s3:	push cx

	mov cx,16
s0:	push cx
	mov cl,es:[di]
        mov ch,0
        jcxz change
	mov [si],cl
s1:	inc di
	inc si	
        pop cx
	loop s0

change:	pop cx
change1:mov byte ptr [bx][si],' '
	inc si
	loop change1

	inc di
	pop cx
	loop s3

show:	mov ax,0b800h
	mov es,ax
	mov si,0
	mov bx,10*160+32*2
	mov di,0
	
	mov cx,4
show1:	push cx
	mov cx,16
show2:	push cx
	mov al,[si]
	mov es:[bx][di],al
	inc si
	add di,2
	pop cx
	loop show2
	mov di,0
	add bx,160
	pop cx
	loop show1

	pop es
	pop ds
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	ret

sub1:	mov ax,0ffffh
	push ax
	mov ax,0
	push ax
	retf

sub2:	mov ax,0
	push ax
	mov es,ax
	mov bx,7c00h
	push bx
	
	mov al,1
	mov ch,0
	mov cl,1
	mov dl,80h
	mov dh,0
	mov ah,2
	int 13h
	
	retf

sub3:	mov ax,cs
	mov ds,ax
	
	mov ax,0
	mov es,ax

	push es:[9*4]
	pop addres
	push es:[9*4+2]
	pop addres[2]

	cli
	mov word ptr es:[9*4],offset int9
	mov es:[9*4+2],cs
	sti
	
	call clear
sub3s:	mov bx,0
	mov cx,6
	mov si,0
	
save:	push cx
	mov al,cmos[bx]
	out 70h,al
	in al,71h
	
	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b
	add ax,3030h
	
	mov time[si],ah
	mov time[si].1,al
	add si,3
	
	inc bx
	pop cx
	loop save

print:	mov ax,0b800h
	mov es,ax
	mov di,13*160+31*2
	mov si,0
	mov cx,17

printf:	mov al,time[si]
	mov es:[di],al
	inc si
	add di,2
	loop printf
	
	jmp sub3s

sub4:	nop
	ret

int9:	push ax
	push bx
	push cx
	push si
	push es
	
	in al,60h

	pushf
	pushf
	pop bx
	and bh,11111100b
	push bx
	popf
	call dword ptr ds:[0]

	cmp al,3bh
	je int9s1
	cmp al,1
	je int9s3
	jmp int9ret

int9s1:	mov ax,0b800h
	mov es,ax
	mov si,1
	mov cx,2000
int9s2:	inc byte ptr es:[si]
	add si,2
	loop int9s2

int9s3:	mov ax,0
	mov es,ax
	cli
	push addres
	pop es:[9*4]
	push addres[2]
	pop es:[9*4+2]
	sti

int9ret:pop es
	pop si
	pop cx
	pop bx
	pop ax
	mov bp,sp
	mov word ptr [bp],0
	mov [bp].2,cs
	iret

clear:	push ax
	push bx
	push cx
	push es
	
	mov ax,0b800h
	mov es,ax
	mov bx,0
	mov cx,2000
clears:	mov byte ptr es:[bx],' '
	and byte ptr es:[bx].1,00000111b
	or byte ptr es:[bx].1,00000111b
	add bx,2
	loop clears

	pop es
	pop cx
	pop bx
	pop ax
	ret

code ends
end start

