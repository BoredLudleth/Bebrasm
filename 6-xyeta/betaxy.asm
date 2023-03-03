.286
.model tiny
.code
org 100h

Start:  mov bx, 0b800h
        mov es, bx
        mov ah, 5eh
        mov bx, 160d * 5 + 80d
Next:   in al, 60h
        mov es:[bx], ax
        add bx, 2
        and bx, 4095d 

        xor cx, cx
        dec cx
Delay:  loop Delay

        cmp al, 1
        jne Next
        mov ax, 4c00h
        int 21h
end     Start