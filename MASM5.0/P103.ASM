assume cs:code

data segment
        db 10 dup (0)
data ends

code segment
start:          mov ax,12666
		mov bx,data
		mov ds,bx
		mov si,0
		call dtoc

		mov dh,8
                mov dl,3
                mov cl,2
                call show_str

                mov ax,4c00h
                int 21h

dtoc:		push bx
		push cx
		push dx
		push si
		push di
		mov bx,0
		push bx
s1:		mov bx,10
		mov dx,0
		div bx
		mov cx,ax
		mov bx,dx
		add bx,30h
		push bx
		inc di
		jcxz s0
		jmp short s1
s0:		mov cx,di
s2:		pop [si]
		add si,2
		loop s2	
		add sp,2	
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		ret

show_str:       push ax
		push bx
		push es
		push si

		mov ax,0b800h
                mov es,ax
                mov al,0a0h
                mul dh
		mov bx,ax
		mov al,2
		mul dl
		add bx,ax
		mov ax,cx
		
s:		mov cl,[si]
		mov ch,0
		jcxz ok
		mov ah,[si]
		mov es:[bx],ah
		mov es:[bx].1,al
		add si,2
		add bx,2
		jmp short s

ok:		pop si
		pop es
		pop bx
		pop ax
		ret
code ends
end start

