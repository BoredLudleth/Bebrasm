.model tiny
.code
org 100h

locals @@

Start:
;--------------------------------------------
; Entry: none
; Exit: none
; Expects: none
; Destroy: AX, BX, CX, ES, 
;--------------------------------------------
ClrScr		proc
		mov cx, 80d*50d
		mov bx, 00b800h
		mov es, bx
		xor bx, bx

		mov ax, 5800h		

@@Next:		mov es:[bx], word ptr ax
		add bx, 2
		loop @@Next				


		ret
		endp

		call ClrScr

		ret
end		Start