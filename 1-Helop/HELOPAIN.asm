
.model tiny
.code
org 100h

Start:		mov ah, 09h			; access to the keyboard
		mov dx, offset HelloPain	
		int 21h

		mov ax, 4c00h
		int 21h

HelloPain:	db 'Hello, Pain', "$"

end		Start