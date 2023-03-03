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

;---------------------------------
; Entry: DX 
; Exit: 
; Expects: 
; Destroy: 
;---------------------------------

HexHex		proc

@@Next:	@@Next:	
        mov si, 0010h
        xor dx, dx
        div si
        mov si, 0000h
        add si, ax
        add si, dx
        cmp si, 0000h
        je Prewrite
        cmp dl, 09h
        ja ABC
        add dh, 4ch
        add dl, 30h
        jmp Skipp
ABC:    add dh, 4ch
        add dl, 55d   
Skipp:   push dx
        add cl, 2
        loop @@Next

Prewrite:
        mov ch, 00h

Write:  pop ax
        mov word ptr es:[bx], ax
        add bx, 2
        loop Write

    	ret
		endp

		call HexHex
        
		mov ax, 4c00h
		int 21h			;exit
end		Start
