assume cs:codesg,ds:datasg,es:table
datasg segment
        db 'welcome to masm!'
datasg ends

table segment
	db 4000 dup (0)
table ends

codesg segment
start:  mov ax,datasg
        mov ds,ax
        mov ax,0B800H
        mov es,ax
        mov bx,0
        mov si,0
        mov cx,16

s:      mov ax,[bx]
        mov es:[720H+si],ax
        mov al,02H
        mov es:[721H+si],al
        inc bx
        add si,2
        loop s

        mov si,0
        mov bx,0
        mov cx,16

s1:     mov ax,[bx]
        mov es:[7C0H+si],ax
        mov al,24H
        mov es:[7C1H+si],al
        inc bx
        add si,2
        loop s1

        mov si,0
        mov bx,0
        mov cx,16

s2:     mov ax,[bx]
        mov es:[860H+si],ax
        mov al,71H
        mov es:[861H+si],al
        inc bx
        add si,2
        loop s2

        mov ax,4c00H
        int 21H
codesg ends
end start