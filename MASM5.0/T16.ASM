assume cs:code

code segment

start:   mov ax,cs

     mov ds,ax

     mov si,offset s             ;����ds:siָ��Դ��ַ

     mov ax,0

     mov es,ax

     mov di,200h            ;����es:diָ��Ŀ���ַ

     mov cx,offset send-offset s ;����cxΪ���䳤��

     cld                ;���ô��䷽��Ϊ��

     rep movsb

;���ж��������������µ�int 7ch�ж����̵���ڵ�ַ

     cli                ;����IF��0�����ж� 

     mov word ptr es:[7ch*4],200h

     mov word ptr es:[7ch*4+2],0

     sti                ;����IF��1�������ж�

;����

     mov ax,4c00h

     int 21h

;�µ�int 7ch�ж�����

s:   jmp short set

table    dw sub1-s+200h,sub2-s+200h,sub3-s+200h,sub4-s+200h

set: push bx

     cmp ah,3           ;�ж�ah�еĹ��ܺ��Ƿ����3

     ja sret

     mov bl,ah

     mov bh,0

     add bx,bx          ;�����Ӧ�ӳ�����table���е�ƫ��

     mov si,offset table-offset s
     call word ptr cs:[bx].200h[si]   ;���ö�Ӧ�Ĺ����ӳ���

sret:    pop bx

     iret

;���ܣ�����

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

;����ǰ��ɫ��al������ɫֵ��(al)��{0,1,2,3,4,5,6,7}

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

;���ñ���ɫ��al������ɫֵ��(al)��{0,1,2,3,4,5,6,7}

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

;���Ϲ���һ��

sub4:    push cx

     push si

     push di

     push es

     push ds

     mov si,0b800h

     mov es,si

     mov ds,si

     mov si,160             ;ds:siָ���N+1��

     mov di,0           ;es:diָ���N��

     cld

     mov cx,24          ;������24��

sub4s:   push cx

     mov cx,160

     rep movsb          ;����

     pop cx

     loop sub4s

     mov cx,80

sub4s1:  mov byte ptr [160*24+si],' '     ;���һ�����

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
