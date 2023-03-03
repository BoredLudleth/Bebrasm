.model tiny
.code
org 100h

Start:		mov bx, 0b800h		; bx uses for saving adress
		mov es, bx		; adress to the beginning video mem
		mov sp, 80d * 25d+ 13d 	; the middle of video mem
		mov dx, 00080h		; in this adress you find number of sym
		mov bx, dx		
		mov byte ptr cl, [bx]	; the counter of loop cx-- (it's like for)
		sub cx, 2
		add dx, 3		; shift to the first cmd sym
		mov al, 03h		; first symbol's color and background	

Next:		mov bx, dx		; bx -> n symbol of cmd
		mov byte ptr ah, [bx]	; al is a symbol which we copy paste
		add al, 4ch		; delta color and back
		mov bx, sp 		; the relative address in video mem																																																	
		mov word ptr es:[bx], ax
		add sp, 2		; we moves on 2 bytes symbol and color
		add dx, 1		; we moves on one in video mem
		loop Next
		
		

		mov ax, 4c00h
		int 21h			;exit
end		Start
	