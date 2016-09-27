assume cs:code
code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset s
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset se-offset s
        cld
        rep  movsb

        mov ax,0
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0

        mov ax,4c00h
        int 21h

s:      push ax
        push bx
        push cx
        push es
        mov ax,0b800h
        mov es,ax
        mov ax,160
        mul dh
        mov bx,ax
        mov ax,2
        mul dl
        add bx,ax
        mov al,cl
s0:     mov cl,[si]
        mov ch,0
        jcxz ok
        mov es:[bx],cl
        mov es:[bx+1],al
        inc si
        add bx,2
        jmp short s0

ok:     pop es
        pop cx
        pop bx
        pop ax
        iret

se:     nop

code ends
end start
