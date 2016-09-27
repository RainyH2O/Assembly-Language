assume cs:code
code segment
int7ch: jmp short set
table dw sub0+200h,sub1+200h,sub2+200h,sub3+200h
set:    push bx
        cmp ah,3
        ja sret
        mov bl,ah
        mov bh,0
        add bx,bx

        call word ptr table[bx].200h

sret:   pop bx
        iret

sub0:   push bx
        push cx
        push es

        mov bx,0b800h
        mov es,bx
        mov bx,0
        mov cx,2000
sub0s:  mov byte ptr es:[bx],' '
        add bx,2
        loop sub0s

        pop es
        pop cx
        pop bx
        ret

sub1:   push bx
        push cx
        push es

        mov bx,0b800h
        mov es,bx
        mov bx,1
        mov cx,2000
sub1s:  and byte ptr es:[bx],11111000b
        or es:[bx],al
        add bx,2
        loop sub1s

        pop es
        pop cx
        pop bx
        ret

sub2:   push bx
        push cx
        push es

        mov bx,0b800h
        mov es,bx
        mov bx,1
        mov cl,4
        shl al,cl
        mov cx,2000
sub2s:  and byte ptr es:[bx],10001111b
        or es:[bx],al
        add bx,2
        loop sub2s

        pop es
        pop cx
        pop bx
        ret

sub3:   push cx
        push si
        push di
        push es
        push ds

        mov si,0b800h
        mov es,si
        mov ds,si
        mov si,160
        mov di,0
        cld
        mov cx,24

sub3s:  push cx
        mov cx,160
        rep movsb
        pop cx
        loop sub3s

        mov cx,80
        mov si,0
sub3s1: mov byte ptr [160*24+si],' '
        add si,2
        loop sub3s1

        pop ds
        pop es
        pop di
        pop si
        pop cx
        ret

int7chend:	nop

start:  mov ax,cs
        mov ds,ax
        mov ax,0
        mov es,ax

        mov si,offset int7ch
        mov di,200h
        mov cx,offset int7chend-offset int7ch

        cld
        rep movsb

	cli
        mov word ptr es:[4*7ch],200h
        mov word ptr es:[4*7ch+2],0
	sti

        mov ax,4c00h
        int 21h
code ends
end start