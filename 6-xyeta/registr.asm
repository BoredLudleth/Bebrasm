.286
.model tiny
.data
Style: db 0bbh, 0cdh, 0c9h, 0bah, 0c8h, 0cdh, 0bch, 0bah
       db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h
       db 0bfh, 0c4h, 0dah, 0b3h, 0c0h, 0c4h, 0d9h, 0b3h 
       db '$'
;rightUpAnkle -line_ leftUpAnkle |line| leftDownAnkle -line_ rightDownAnkle |line|
.code
org 100h

Start:  jmp EOP

New09   proc
        push ax bx es ds              ;copy data
            
        in al, 60h
        cmp al, 3bh
        jne Common09

        cmp MyFlag, 01h
        je Zero

One: 
        mov MyFlag, 01h
        jmp Af

Zero:  
        mov MyFlag, 00h

Af:        in al, 61h                  ; blinking
        or al, 80h
        out 61h, al
        and al, not 80h
        out 61h, al

        mov al, 20h                 ; end of interrupt
        out 20h, al

        pop ds es bx ax
        iret
        endp
                
Common09:        pop ds es bx ax
        
        db 0eah
        Old09Ofs dw 0h
        Old09Seg dw 0h

        iret
        endp

New08   proc
        push ax bx cx dx es si di sp bp             ;copy data

        cmp MyFlag, 01h
        jne Common08

        call DrawRegs
        pop bp sp di si es dx cx bx ax

        push ax bx cx dx es si di sp bp 

        push 64d        ;x
        push 1d        ;y
        push 10d         ;length
        push 5d         ;height
        push 5eh        ;backcolor
        push 3d        ;style

        call Frame
        add sp, 12d

Common08:        pop bp sp di si es dx cx bx ax

        db 0eah
        Old08Ofs  dw 0h
        Old08Seg dw 0h
        
        iret
        endp

Frame   proc
        push bp
        mov bp, sp

        mov ax, 5288h
        mov ds, ax

        xor ax, ax
        mov ax, [bp + 4]
        sub ax, 1
        mov bl, 8
        mul bl


        mov si, offset Style
        add si, ax          ;style
        sub si, 8h

        mov cx, [bp + 6]              ; color
        
        mov bx, [bp + 8]            ; heigth
        mov dl, bl
        mov bx, [bp + 10] 
        mov dh, bl          ; length

        mov bx, [bp + 12]              ; Y
        mov al, bl
        mov bx, [bp + 14]               ; X
        mov ah, bl           
        
        mov bx, 0b800h;
        mov es, bx


        mov ch, cl
        mov cl, 00h
        push cx                     ; color in stack
        xor cx, cx


        sub al, 1
        mov cl, ah
        mov ch, 160
        mul ch
        mov ch, 00h
        add ax, cx
        add ax, cx
        mov bx, ax

        mov cl, dh

        pop ax
        push ax
        lodsb
        mov word ptr es:[bx], ax
        sub cl, 1
        sub bx, 2


        pop ax
        push ax
        lodsb

UpLin:  mov word ptr es:[bx], ax
        sub bx, 2
        loop UpLin

        mov cl, dl
        
        pop ax
        push ax
        lodsb

        mov es:[bx], ax
        sub cl, 1
        add bx,160

        pop ax
        push ax
        lodsb

LeftLin:  mov es:[bx], ax
        add bx, 160
        loop LeftLin

        mov cl, dh

        pop ax
        push ax
        lodsb

        mov es:[bx], ax
        sub cl, 1
        add bx, 2

        pop ax
        push ax
        lodsb

DownLin:  mov es:[bx], ax
        add bx, 2
        loop DownLin

        mov cl, dl

        pop ax
        push ax
        lodsb

        mov es:[bx], ax
        sub cl, 1
        sub bx, 160

        pop ax
        push ax
        lodsb

RightLin:  mov es:[bx], ax
        sub bx, 160
        loop RightLin
        pop ax

        pop bp
        ret
        endp

DrawRegs    proc
        push ax bx cx dx   ;ax
        push ax
        push 160d * 1 + 120d

        mov bx, 0b800h                  ;print ax = 
        mov es, bx
        mov bx, 160d * 1 + 110d
        mov ah, 4ch                     ;color
        mov al, 'a'
        mov es:[bx], ax
        add bx, 2
        mov al, 'x'
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax
        add bx, 2
        mov al, '='
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax

        call HexHex
        pop ax
        pop bx
        pop dx cx bx ax

        push ax bx cx dx  ;bx
        push bx
        push 160d * 2 + 120d

        mov bx, 0b800h                  ;print bx = 
        mov es, bx
        mov bx, 160d * 2 + 110d
        mov ah, 4ch
        mov al, 'b'
        mov es:[bx], ax
        add bx, 2
        mov al, 'x'
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax
        add bx, 2
        mov al, '='
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax

        call HexHex
        pop ax
        pop bx
        pop dx cx bx ax

        push ax bx cx dx  ;cx
        push cx
        push 160d * 3 + 120d

        mov bx, 0b800h                  ;print cx = 
        mov es, bx
        mov bx, 160d * 3 + 110d
        mov ah, 4ch
        mov al, 'c'
        mov es:[bx], ax
        add bx, 2
        mov al, 'x'
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax
        add bx, 2
        mov al, '='
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax

        call HexHex
        pop ax
        pop bx
        pop dx cx bx ax

        push ax bx cx dx ;dx
        push dx
        push 160d * 4 + 120d

        mov bx, 0b800h                  ;print ax = 
        mov es, bx
        mov bx, 160d * 4 + 110d
        mov ah, 4ch
        mov al, 'd'
        mov es:[bx], ax
        add bx, 2
        mov al, 'x'
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax
        add bx, 2
        mov al, '='
        mov es:[bx], ax
        add bx, 2
        mov al, ' '
        mov es:[bx], ax

        call HexHex
        pop ax
        pop bx
        pop dx cx bx ax

        ret
        endp

HexHex		proc
        push bp
        mov bp, sp

        mov ax, [bp + 6]

        mov bx, 0b800h
	    mov es, bx

        mov bx, [bp + 4]

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
        add bx, 2
        mov word ptr es:[bx], 4c30h
        add bx, 2
        mov word ptr es:[bx], 4c30h
        add bx, 2
        mov word ptr es:[bx], 4c30h
        add bx, 2
        xor ax, ax

        pop bp
        
        ret
	endp

EOP:
        MyFlag db 00h
        cli
        xor bx, bx
        mov es, bx
        mov bx, 4 * 8               ; 8 interruption - timer
        mov ax, es:[bx]
        mov Old08Ofs, ax            ; old interrupt
        mov es:[bx], offset New08   ; change on new version
        mov ax, es:[bx + 2]
        mov Old08Seg, ax            ; pointer on segment
        mov ax, cs
        mov es:[bx + 2], ax         ; NewSegment
        sti

        cli
        xor bx, bx
        mov es, bx
        mov bx, 4 * 9               ; 9 interruption - keyboard
        mov ax, es:[bx]
        mov Old09Ofs, ax            ; old interrupt
        mov es:[bx], offset New09   ; change on new version
        mov ax, es:[bx + 2]
        mov Old09Seg, ax            ; pointer on segment
        mov ax, cs
        mov es:[bx + 2], ax         ; NewSegment
        sti
        
        mov ax, 3100h
        mov dx, offset EOP
        shr dx, 4
        inc dx
	    int 21h
        
end		Start