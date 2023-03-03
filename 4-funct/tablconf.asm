PrintBin:
        mov bx, 160 * 4 + 8
        mov al, 'B'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'i'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'n'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2

PrintDec:
        mov bx, 160 * 4 + 60
        mov al, 'D'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'e'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'c'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2

PrintHex:
        mov bx, 160 * 4 + 80
        mov al, 'H'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'e'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'x'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2

PrintSum:
        mov bx, 160 * 5 + 2
        mov al, 'S'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'u'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'm'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2

PrintSub:
        mov bx, 160 * 6 + 2
        mov al, 'S'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'u'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'b'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2

PrintMul:
        mov bx, 160 * 7 + 2
        mov al, 'M'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'u'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'l'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2

PrintDiv:
        mov bx, 160 * 8 + 2
        mov al, 'D'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'i'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
        mov al, 'v'
        mov ah, 39h
        mov es:[bx], ax
        add bx, 2
