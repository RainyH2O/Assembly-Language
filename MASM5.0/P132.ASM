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

s:      push bp
s0:	dec cx
	jcxz ok
        mov bp,sp
        add [bp].2,bx
ok:     pop bp
	iret

se:     nop

code ends
end start
