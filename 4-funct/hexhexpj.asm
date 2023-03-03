;-----------------------------------------------------------
; Entry: AX - number to convert 
; Exit: Printing on the screen number in hex
; Expects: ES:[BX]-in the video mem
; Destroy: AX, BX, CX, SI
;-----------------------------------------------------------
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
