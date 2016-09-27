assume cs:code

code segment

start:   mov ax,cs

     mov ds,ax

     mov si,offset s             ;设置ds:si指向源地址

     mov ax,0

     mov es,ax

     mov di,200h            ;设置es:di指向目标地址

     mov cx,offset send-offset s ;设置cx为传输长度

     cld                ;设置传输方向为正

     rep movsb

;在中断向量表中设置新的int 7ch中断例程的入口地址

     cli                ;设置IF＝0屏蔽中断 

     mov word ptr es:[7ch*4],200h

     mov word ptr es:[7ch*4+2],0

     sti                ;设置IF＝1不屏蔽中断

;结束

     mov ax,4c00h

     int 21h

;新的int 7ch中断例程

s:   jmp short set

table    dw sub1-s+200h,sub2-s+200h,sub3-s+200h,sub4-s+200h

set: push bx

     cmp ah,3           ;判断ah中的功能号是否大于3

     ja sret

     mov bl,ah

     mov bh,0

     add bx,bx          ;计算对应子程序在table表中的偏移

     mov si,offset table-offset s
     call word ptr cs:[bx].200h[si]   ;调用对应的功能子程序

sret:    pop bx

     iret

;功能：清屏

sub1:    push bx

     push cx

     push es

     mov bx,0b800h

     mov es,bx

     mov bx,0

     mov cx,2000

subles:  mov byte ptr es:[bx],' '

     add bx,2

     loop subles

     pop es

     pop cx

     pop bx

     ret

;设置前景色，al传送颜色值，(al)∈{0,1,2,3,4,5,6,7}

sub2:    push bx

     push cx

     push es

     mov bx,0b800h

     mov es,bx

     mov bx,1

     mov cx,2000

sub2s:   and byte ptr es:[bx],11111000b

     or es:[bx],al

     add bx,2

     loop sub2s

     pop es

     pop cx

     pop bx

     ret

;设置背景色，al传送颜色值，(al)∈{0,1,2,3,4,5,6,7}

sub3:    push ax

     push bx

     push cx

     push es

     mov cl,4

     shl al,cl

     mov bx,0b800h

     mov es,bx

     mov bx,1

     mov cx,2000

sub3s:   and byte ptr es:[bx],10001111b

     or es:[bx],al

     add bx,2

     loop sub3s

     pop es

     pop cx

     pop bx

     pop ax

     ret

;向上滚动一行

sub4:    push cx

     push si

     push di

     push es

     push ds

     mov si,0b800h

     mov es,si

     mov ds,si

     mov si,160             ;ds:si指向第N+1行

     mov di,0           ;es:di指向第N行

     cld

     mov cx,24          ;共复制24行

sub4s:   push cx

     mov cx,160

     rep movsb          ;复制

     pop cx

     loop sub4s

     mov cx,80

sub4s1:  mov byte ptr [160*24+si],' '     ;最后一行清空

     add bx,2

     loop sub4s1

     pop ds

     pop es

     pop di

     pop si

     pop cx

     ret

send:    nop

code ends

end start

