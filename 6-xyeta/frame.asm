.model tiny
.data
Style: db 0bbh, 0cdh, 0c9h, 0bah, 0c8h, 0cdh, 0bch, 0bah
       db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h
       db 0bfh, 0c4h, 0dah, 0b3h, 0c0h, 0c4h, 0d9h, 0b3h 
       db '$'
;rightUpAnkle -line_ leftUpAnkle |line| leftDownAnkle -line_ rightDownAnkle |line|
.code
org 100h

locals @@

Start: jmp EOP
;Information in stack is reflection of this
;X Y length height color_background style_frame 
Frame   proc
        push bp
        mov bp, sp


        mov ax, [bp + 4]
        sub ax, 1
        mov bl, 8
        mul bl
        mov si, offset Style
        add si, ax          ;style

        mov cx, [bp + 6]              ; color
        
        mov bx, [bp + 8]            ; heigth
        mov dl, bl
        mov bx, [bp + 10] 
        mov dh, bl          ; length

        mov bx, [bp + 12]              ; Y
        mov al, bl
        mov bx, [bp + 14]               ; X
        mov ah, bl           
        
        mov bx, 0b800h;
        mov es, bx


        mov ch, cl
        mov cl, 00h
        push cx                     ; color in stack
        xor cx, cx


        sub al, 1
        mov cl, ah
        mov ch, 160
        mul ch
        mov ch, 00h
        add ax, cx
        add ax, cx
        mov bx, ax

        mov cl, dh

        pop ax
        push ax
        lodsb
        mov word ptr es:[bx], ax
        sub cl, 1
        sub bx, 2


        pop ax
        push ax
        lodsb

UpLin:  mov word ptr es:[bx], ax
        sub bx, 2
        loop UpLin

        mov cl, dl
        
        pop ax
        push ax
        lodsb

        mov es:[bx], ax
        sub cl, 1
        add bx,160

        pop ax
        push ax
        lodsb

LeftLin:  mov es:[bx], ax
        add bx, 160
        loop LeftLin

        mov cl, dh

        pop ax
        push ax
        lodsb

        mov es:[bx], ax
        sub cl, 1
        add bx, 2

        pop ax
        push ax
        lodsb

DownLin:  mov es:[bx], ax
        add bx, 2
        loop DownLin

        mov cl, dl

        pop ax
        push ax
        lodsb

        mov es:[bx], ax
        sub cl, 1
        sub bx, 160

        pop ax
        push ax
        lodsb

RightLin:  mov es:[bx], ax
        sub bx, 160
        loop RightLin
        pop ax

        pop bp
        ret
		endp

EOP:    ;X Y length height color_background style_frame 
        push 10d        ;x - 1
        push 1d        ;y - 1
        push 3d         ;length + 1
        push 3d         ;height +1
        push 4ch        ;backcolor
        push 2d        ;style
        call Frame
        pop dx
        pop dx
        pop dx
        pop dx
        pop dx
        pop dx


		mov ax, 4c00h
		int 21h

end		Start