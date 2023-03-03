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

Start:

ScrToStck:      mov bx, 00080h
                xor cx, cx
                mov byte ptr cl, [bx]
                sub cx, 1           ; cx - number of symbols

                mov bx, 00082h
                xor dx, dx          ; symbol

ReadSym:
                mov byte ptr dl, [bx]
                cmp dl, 20h         ; is space?
                je Send
                sub dx, 0030h       ; from char to int

                mov ch, 10d
                mul ch
                add ax, dx          ; add 1 digit of dec num

                mov ch, 00h          ; counter to default count
                add bx, 1
                loop ReadSym 

                push ax
                jmp DataProcess

Send:           push ax
                add bx, 1
                xor ax, ax
                loop ReadSym   
;Information in stack is reflection of this
;X Y length height color_background style_frame 

DataProcess:    pop ax
                sub ax, 1
                mov bl, 8
                mul bl
                mov si,offset Style
                add si, ax          ;style

                ;mov ax, Offset Style
                ;add ax, si          
                ;mov si, ax          ; adress to our style symbols
                pop cx              ; color
                
                pop bx              ; heigth
                mov dl, bl
                pop bx
                mov dh, bl          ; length

                pop bx              ; Y
                mov al, bl
                pop bx              ; X
                mov ah, bl           
                
                mov bx, 0b800h;
                mov es, bx


Frame   proc
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

        ;mov ax, Offset Style
        ;mov ds, ax 

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
        ret
		endp

        call Frame

		mov ax, 4c00h
		int 21h

end		Start