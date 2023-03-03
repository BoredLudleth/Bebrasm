;-----------------------------------------------------------
; Entry: AX - number to convert 
; Exit: Printing on the screen number in binary
; Expects: ES:[BX]-in the video mem, CX number of digit (16)
; Destroy: AX, BX, CX
;-----------------------------------------------------------
HexBin		proc

@@Next:
		shl ax, 1						; move
		jc One
		mov word ptr es:[bx], 7b30h		; one color and zero
		jmp Lop	
			
Lop:		add bx, 2					; delta in video mem
		loop @@Next
		jmp Retuurn

One:		mov word ptr es:[bx], 4c31h	; input color and 1
		jmp Lop

Retuurn:		ret						; exit
		endp
