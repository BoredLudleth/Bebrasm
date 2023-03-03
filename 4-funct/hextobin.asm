.model tiny
.code
org 100h

locals @@

Start:		mov ax, 12cch
		mov bx, 0b800h
		mov es, bx
		mov dx, 0000h
		xor bx, bx

		call HexBin
;---------------------------------
; Entry: DX 
; Exit: 
; Expects: 
; Destroy: 
;---------------------------------

HexBin		proc
		mov cx, 8d

@@Next:		shl dx, 1	
		shl ax, 1	
		jc One
		mov word ptr es:[bx], 7b30h
		jmp Lop	
			
Lop:		add bx, 2
		loop @@Next
		jmp Return

One:		mov word ptr es:[bx], 4c31h
		jmp Lop

Return:		ret
		endp

		ret
end		Start
