assume cs:code
data segment
        db 'Welcome to masm!',0
data ends

code segment
start:          mov dh,8
                mov dl,3
                mov cl,2
                mov ax,data
                mov ds,ax
                mov si,0
                call show_str

                mov ax,4c00h
                int 21h
show_str:       push cx
		mov ax,0b800h
                mov es,ax
                mov al,0a0h
                mul dh
		mov bx,ax
		mov al,2
		mul dl
		add bx,ax
		pop ax
		
s:		mov cl,[si]
		mov ch,0
		jcxz ok
		mov ah,[si]
		mov es:[bx],ah
		mov es:[bx].1,al
		inc si
		add bx,2
		jmp short s

ok:		ret

code ends
end start

