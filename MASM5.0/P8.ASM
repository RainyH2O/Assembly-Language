assume cs:codesg
data segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'

        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw 11542,14430,15257,17800
data ends

table segment
        db 21 dup ('year summ ne ?? ')
table ends

codesg segment
start:  mov ax,data
        mov ss,ax
        mov bp,0
        mov ax,table
        mov ds,ax
        mov bx,0
        mov cx,21
	
	mov ax,0
	mov es,ax

s:      mov es:[200],cx
        mov cx,2
        mov si,0

s0:     mov ax,[bp]
	mov [bx+0+si],ax
        add bp,2
        add si,2
        loop s0
        mov cx,es:[200]
        add bx,10H
        loop s

	mov cx,21
	mov bx,0
s1:  	mov es:[200],cx
        mov cx,2
        mov si,0

s2:     mov ax,[bp]
	mov [bx+5+si],ax
        add bp,2
        add si,2
        loop s2
        mov cx,es:[200]
        add bx,10H
        loop s1

	mov cx,21
	mov bx,0
s3:  	mov ax,[bp]
	mov [bx+10],ax
        add bp,2
        add bx,10H
        loop s3

	mov bx,0
	mov cx,21

s4:	mov si,0
	mov ax,[bx+5+si]
	add si,2
	mov dx,[bx+5+si]
	mov es:[200],bx
	mov bx,[bx+10]
	div bx
	mov bx,es:[200]
	mov [bx+13],ax
	add bx,10H
	loop s4

        mov ax,4c00h
        int 21h
codesg ends
end start
