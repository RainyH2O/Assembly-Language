assume cs:codesg,ds:datasg
datasg segment
        db 'welcome to masm!'
datasg ends

codesg segment
start:  mov ax,datasg
        mov ds,ax
        mov ax,0B800H
        mov ss,ax
        mov bx,0
	mov bp,06E0H
        mov si,0
        mov cx,16

s:      mov ax,[bx]
        mov [bp].64[si],ax
        mov al,02H
        mov [bp].65[si],al
        inc bx
        add si,2
        loop s

	add bp,0A0H
        mov si,0
        mov bx,0
        mov cx,16

s1:     mov ax,[bx]
        mov [bp].64[si],ax
        mov al,24H
        mov [bp].65[si],al
        inc bx
        add si,2
        loop s1

	add bp,0A0H
        mov si,0
        mov bx,0
        mov cx,16

s2:     mov ax,[bx]
        mov [bp].64[si],ax
        mov al,71H
        mov [bp].65[si],al
        inc bx
        add si,2
        loop s2

        mov ax,4c00H
        int 21H
codesg ends
end start