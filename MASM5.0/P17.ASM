assume cs:code
code segment
int7ch: jmp short s
table   dw sub0,sub1
        db 0,1,2,3

s:   	push ax
        push cx
        push dx
        push di

        push bx
        push es
        
        cmp ah,2
        ja int7chret
        mov bl,ah
        mov bh,0
        mov di,bx
        add di,di

        mov ax,dx
        mov dx,0
        mov cx,1440
        div cx
        mov bx,ax
        mov ax,dx
        mov cl,18
        div cl
        mov ch,al
        mov cl,ah
        add cl,1
        mov al,1
        mov dh,bl
        mov dl,0
	
	pop es
	pop bx

        jmp word ptr table[di]
        
sub0:   mov ah,2
        int 13h
        jmp int7chret
sub1:   mov ah,3
        int 13h

int7chret:	pop di
                pop dx
                pop cx
                pop ax
                iret

int7chend:      nop

start:  mov ax,cs
        mov ds,ax
        mov si,offset int7ch

        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,offset int7chend-offset int7ch
        cld
        rep movsb
	
        cli
        mov byte ptr es:[7ch*4],0
        mov byte ptr es:[7ch*4+2],20h
        sti

        mov ax,4c00h
        int 21h

code ends
end start

