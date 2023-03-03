;-----------------------------------------------------------
; Entry: AX - number to convert 
; Exit: Printing on the screen number in dec
; Expects: ES:[BX]-in the video mem, CX number of digit
; Destroy: AX, BX, CX, SI
;-----------------------------------------------------------
HexDec		proc
        xor cx, cx
@@Next:	
        mov si, 000ah                 ; we divide on si
        xor dx, dx                    ; clear dx for good result
        div si                        ; dividing
        mov si, 0000h
        add si, ax
        add si, dx
        cmp si, 0000h                 ; check on the end of next
        je Prewrite
        add dh, 4ch                   ; color
        add dl, 30h                   ; delta for ascii symbol
        push dx
        add cl, 2                     ; count digits (extra 1 for looping next)
        loop @@Next

Prewrite:
        cmp cx, 0000h                 ; checking it on zero
        je ExWrite

Write:  pop ax                        ; writing number
        mov word ptr es:[bx], ax
        add bx, 2                     ; delta in the video mem
        loop Write                    ; working while num_of_digits != 0
        xor ax, ax
        ret
		endp
        
ExWrite:
        mov word ptr es:[bx], 4c30h   ; if the result is zero
        xor ax, ax
        ret
		endp