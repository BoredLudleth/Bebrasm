.model tiny
.code
org 100h

locals @@

Start:	mov ax, 12cch
	mov bx, 0b800h
	mov es, bx
        xor bx, bx
        xor dx, dx
        mov si, 0010h
        mov ch, 4ch

;        pop dx
;        pop cx                          ; take 2 numbers
;        push cx                         ; return copies to stack
;        push dx
;        add ax, cx                      ; the result of add in ax
;        add ax, dx
	xor bx, bx
        xor cx, cx
        add bx, 160 * 5 + 80            ; place in video memory

;---------------------------------
; Entry: DX 
; Exit: 
; Expects: 
; Destroy: 
;---------------------------------

HexHex		proc


@@Next:
        mov si, 0010h                   ;si = 16d
        xor dx, dx
        div si                          ; ax / si
        mov si, 0000h
        add si, ax
        add si, dx
        cmp si, 0000h                   ; check(the_end_of_converting)
        je Prrewrite

        cmp dl, 09h                     ; isalpha(dl)
        ja ABC
        add dh, 4ch
        add dl, 30h
        jmp Skipp
ABC:    add dh, 4ch                     ; dh is alpha
        add dl, 55d   
Skipp:   push dx                        ;  cl = num of digits(after for)
        add cl, 2
        loop @@Next

Prrewrite:                              ; check on 0
        cmp cx, 0000h
        je ExxxWrite

Wrrite:  pop ax
        mov word ptr es:[bx], ax        ; print (num)
        add bx, 2
        loop Wrrite

    	ret
		endp
ExxxWrite:                              ;print (0)
        mov word ptr es:[bx], 4c30h
        xor ax, ax
        ret
		endp


		call HexHex
        
		mov ax, 4c00h
		int 21h			;exit
end		Start
