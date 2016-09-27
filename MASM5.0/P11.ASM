assume cs:codesg

datasg segment
        db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends

codesg segment

begin:  mov ax,datasg
        mov ds,ax
        mov si,0
        call letterc

        mov ax,4c00h
        int 21h

letterc:push cx
        
s:      mov cl,[si]
        mov ch,0
        jcxz over
        cmp cl,61h
        jb s0
        cmp cl,7ah
        ja s0
        and cl,11011111b
        mov [si],cl

s0:     inc si
        jmp s

over:   pop cx
        ret

codesg ends
end begin
