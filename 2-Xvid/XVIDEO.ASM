.model tiny
.code
org 100h

Start:		mov bx, 0b800h
		mov es, bx
		mov ax, 0058h

		xor bx, bx
		
Next:		mov word ptr es:[bx],ax
		add ax, 0100h
		add bx, 2
		loop Next

		mov ax, 4c00h
		int 21h

end 		Start