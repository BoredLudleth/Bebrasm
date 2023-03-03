.model tiny
.code
org 100h

locals @@

Start:  
CleanScr:mov   ax, 0600h   ;Запрос на очистку экрана.
        mov   bh, 07      ;Нормальный атрибут (черно/белый).
        mov   cx, 0000    ;Верхняя левая позиция.
        mov   dx, 184Fh   ;Нижняя правая позиция.
        int   10h  



        mov bx, 00080h
        xor cx, cx
        mov byte ptr cl, [bx]           ;preparation before function
        sub cx, 2
        mov bx, 00082h
        call FromScrToStck              ;number 1 and push it to stack
        push dx
        call FromScrToStck              ;number 2
        push dx


        pop dx
        pop cx                          ; take 2 numbers
        push cx                         ; return copies to stack
        push dx
        xor ax, ax
        add ax, dx                      ; the result of sum in ax
        add ax, cx
        mov bx, 0b800h
		mov es, bx                      ; access to the video memory
		mov dx, 0000h
		xor bx, bx
        add bx, 160 * 5 + 8             ; place in video memory
		mov cx, 16d                     ; number of digits
        call HexBin

        pop cx                          ; take 2 numbers
        pop dx                          ; return copies to stack
        push dx
        push cx
        add ax, dx
        sub ax, cx                      ; the result of sub in ax
		mov dx, 0000h
		xor bx, bx
        add bx, 160 * 6 + 8             ; place in video memory
		mov cx, 16d
        call HexBin

        pop cx
        pop ax                          ; take 2 numbers
        push ax                         ; return copies to stack
        push cx
        mul cx                          ; the result of mul in ax
		mov dx, 0000h
		xor bx, bx
        add bx, 160 * 7 + 8             ; place in video memory
		mov cx, 16d
        call HexBin

        pop cx
        pop ax                          ; take 2 numbers
        push ax                         ; return copies to stack
        push cx
        div cx                          ; the result of div in ax
		xor bx, bx
        add bx, 160 * 8 + 8             ; place in video memory
		xor dx, dx
		mov cx, 16d
        call HexBin



        pop dx
        pop cx                          ; take 2 numbers
        push cx                         ; return copies to stack
        push dx
        add ax, cx
        add ax, dx                      ; the result of add in ax
		xor bx, bx
        add bx, 160 * 5 + 60            ; place in video memory
        call HexDec

        pop dx
        pop cx                          ; take 2 numbers
        push cx                         ; return copies to stack
        push dx
        add ax, cx
        sub ax, dx                      ; the result of sub in ax
		xor bx, bx
        add bx, 160 * 6 + 60            ; place in video memory
        call HexDec

        pop cx
        pop ax                          ; take 2 numbers
        push ax                         ; return copies to stack
        push cx
        mul cx                          ; the result of mul in ax
		xor bx, bx
        add bx, 160 * 7 + 60            ; place in video memory
        call HexDec

        pop cx
        pop ax                          ; take 2 numbers
        push ax                         ; return copies to stack
        push cx
        xor dx, dx
        div cx                          ; the result of div in ax
        xor bx, bx
        add bx, 160 * 8 + 60            ; place in video memory
        call HexDec



        pop dx
        pop cx                          ; take 2 numbers
        push cx                         ; return copies to stack
        push dx
        add ax, cx                      ; the result of add in ax
        add ax, dx
		xor bx, bx
        xor cx, cx
        add bx, 160 * 5 + 80            ; place in video memory
        call HexHex

        pop dx
        pop cx                          ; take 2 numbers
        push cx                         ; return copies to stack
        push dx
        xor ax, ax
        add ax, cx
        sub ax, dx                      ; the result of sub in ax
		xor bx, bx
        xor cx, cx
        add bx, 160 * 6 + 80            ; place in video memory
        call HexHex

        pop cx
        pop ax                          ; take 2 numbers
        push ax                         ; return copies to stack
        push cx
        mul cx                          ; the result of mul in ax
		xor bx, bx
        xor cx, cx
        add bx, 160 * 7 + 80            ; place in video memory
        call HexHex

        pop cx
        pop ax                          ; take 2 numbers
        push ax                         ; return copies to stack
        push cx
        xor dx, dx
        div cx                          ; the result of div in ax
        xor bx, bx
        xor cx, cx
        add bx, 160 * 8 + 80            ; place in video memory
        call HexHex

        call Frame

        INCLUDE tablconf.asm


        jmp Retu            ; don't go to functions

        

;--------------------------------------------
; Entry: BX = 00080h, in CX number of symbols
; Exit: number, from screen DX
; Expects: function number from screen to DX
; Destroy: AX, BX, CX, ES 
;--------------------------------------------
FromScrToStck   proc
        xor dx, dx
TakeNum:  xor ax, ax
        mov byte ptr al, [bx]
        cmp ax, 0020h
        je Exittake
        sub ax, '0' 
        shl dx, 1           ; multiply dx on 2
        add ax, dx          ; ax = ax + 2dx
        shl dx, 2           ; dx equal dx * 8 in beg
        add dx, ax
        add bx, 1
        loop TakeNum
Exittake:

        add bx, 1
        ret
        endp
;--------------------------------------------
; Entry: BP -
; Exit: none
; Expects: string to screen
; Destroy: AX, BX, CX, ES 
;--------------------------------------------

INCLUDE hexbinpj.asm        ; include cpp-es
INCLUDE hexdecpj.asm
INCLUDE hexhexpj.asm
INCLUDE framepj.asm

Retu:   mov ax, 4c00h       ; return 0
		int 21h

end Start

/m2