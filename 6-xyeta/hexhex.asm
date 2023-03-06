.model tiny
.code
org 100h

locals @@

Start:	
        mov ax, 1dcch
        push ax
        call HexHex

;---------------------------------
; Entry: AX
; Exit: 
; Expects: 
; Destroy: 
;---------------------------------
jmp Ender
HexHex		proc
        push bp
        mov bp, sp

        mov ax, [bp + 4]

        mov bx, 0b800h
	    mov es, bx

        mov bx, 160d * 5 + 120d

        xor cx, cx
        xor dx, dx

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

        pop bp
    	
        ret
		endp
ExxxWrite:                              ;print (0)
        mov word ptr es:[bx], 4c30h
        xor ax, ax

        pop bp
        
        ret
		endp

        
Ender:		mov ax, 4c00h
		int 21h			;exit
end		Start
