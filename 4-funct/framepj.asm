;-----------------------------------------------------------
; Entry: AX, DX - parameters of frame
; Exit: drawing a frame
; Expects: none
; Destroy: AX, BX, CX, DX, SI
;-----------------------------------------------------------
Frame   proc
        mov dl, 5d ;height
        mov dh, 48d ;length             ;parameters
        mov al, 5d ;y thing
        mov ah, 48d ;x thing
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
        mov bx, ax                      ; place in video mem

        mov ax, si

        xor cx, cx
        mov cl, dh                      ; length of up line

        mov es:[bx], 9abbh              ; draw ankle
        sub cl, 1
        sub bx, 2

UpLin:  mov es:[bx], 9acdh              ; drawing up line
        sub bx, 2
        loop UpLin

        mov cl, dl

        mov es:[bx], 9ac9h              ; draw ankle
        sub cl, 1
        add bx,160

LeftLin:  mov es:[bx], 9abah            ; drawing left line
        add bx, 160
        loop LeftLin

        mov cl, dh

        mov es:[bx], 9ac8h              ; draw ankle
        sub cl, 1
        add bx, 2

DownLin:  mov es:[bx], 9acdh             ; drawing left line
        add bx, 2
        loop DownLin

        mov cl, dl

        mov es:[bx], 9abch              ; draw ankle
        sub cl, 1
        sub bx, 160

RightLin:  mov es:[bx], 9abah           ; drawing right line
        sub bx, 160
        loop RightLin
       
        ret
		endp

