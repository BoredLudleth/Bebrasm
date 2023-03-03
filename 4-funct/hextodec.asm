.model tiny
.code
org 100h

locals @@

Start:		mov ax, 1234d
		mov bx, 0b800h
		mov es, bx
        xor bx, bx
        xor dx, dx
        mov dh, 10d
        mov ch, 4ch

;---------------------------------
; Entry: DX 
; Exit: 
; Expects: 
; Destroy: 
;---------------------------------

HexDec		proc

@@Next:		  
        div dh
        mov cl, ah
        add cx, 0030h
        cmp ax, 0
        je Prewrite
        mov ah, 00h
        push cx
        add dl, 1
        loop @@Next

Prewrite:        mov dh, 00h
        mov cx, dx

Write:  pop ax
        mov word ptr es:[bx], ax
        add bx, 2
        loop Write

    	ret
		endp

		call HexDec
        
		mov ax, 4c00h
		int 21h			;exit
end		Start
