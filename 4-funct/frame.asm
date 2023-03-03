.model tiny
.code
org 100h

locals @@

Start:

        mov dl, 10d ;height
        mov dh, 20d ;length
        mov al, 3d ;y thing
        mov ah, 30d ;x thing
        mov bx, 0b800h;
        mov es, bx
        
        mov si, ax

        sub al, 1
        mov cl, ah
        mov ch, 160
        mul ch
        mov ch, 00h
        add ax, cx
        add ax, cx
        mov bx, ax

        mov ax, si
;---------------------------------
; Entry: DX 
; Exit: 
; Expects: 
; Destroy: 
;---------------------------------

Frame   proc

        xor cx, cx
        mov cl, dh

        mov es:[bx], 4cbbh
        sub cl, 1
        sub bx, 2

UpLin:  mov es:[bx], 4ccdh
        sub bx, 2
        loop UpLin

        mov cl, dl

        mov es:[bx], 4cc9h
        sub cl, 1
        add bx,160

LeftLin:  mov es:[bx], 4cbah
        add bx, 160
        loop LeftLin

        mov cl, dh

        mov es:[bx], 4cc8h
        sub cl, 1
        add bx, 2

DownLin:  mov es:[bx], 4ccdh
        add bx, 2
        loop DownLin

        mov cl, dl

        mov es:[bx], 4cbch
        sub cl, 1
        sub bx, 160

RightLin:  mov es:[bx], 4cbah
        sub bx, 160
        loop RightLin
       
        ret
		endp

        call Frame

		mov ax, 4c00h
		int 21h

end		Start
