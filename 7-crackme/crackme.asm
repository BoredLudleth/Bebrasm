.286
.model tiny
.data
HenloUser: db "Henlo, enter password, sir!", 0ah,'$'
Congratulations: db "Your are right, let's celebrate and suck some dick", '$'
Loser: db "Suck dick, loser", '$'
Password: db 11, "oralcumshot"         ;length of password, password
YourTry: db 254d, 253 dup ('$')   ;your max, length of read password, '$...'
.code 
org 100h

locals @@

Start:
        jmp EOP

EnterPassword   proc
        push bp
        mov bp, sp
        push ax dx
;в идеале сделать какую-нибудь граф оболочку
        mov dx, offset Yourtry
        mov ah, 0ah
        int 21h                 ; read password

        pop dx ax

        pop bp
        ret
		endp

CheckPassword   proc
        push bp
        mov bp, sp

        mov si, [bp + 6]        ;Password
        mov di, [bp + 4]        ;YourTry

        push si di
        call PasswordCmp
        pop di si

        mov bl, ds:[si]        ;length of password
        cmp al, bl
        jae SUCCSESS
        jmp FAILED

SUCCSESS:
        mov ah, 09h			; access to the keyboard
		mov dx, offset Congratulations
		int 21h
        jmp ExitCheck
FAILED:
        mov ah, 09h			; access to the keyboard
		mov dx, offset Loser
		int 21h
        jmp ExitCheck
        
        ;сравнить количество совпавших в пароле букв с длинной пароля, если совпало >=len, то jump SUCCSESS, else jump FALSE

ExitCheck:
        pop bp
        ret
        endp

PasswordCmp proc
        push bp
        mov bp, sp

        mov si, [bp + 6]        ;password
        mov di, [bp + 4]        ;YourTry

        xor ax, ax              ;counter to 0

        add si, 1
        add di, 2

Comporation:
        mov bh, ds:[si]
        mov bl, es:[di]
        cmp bh, bl
        je CmpTrue
        jmp CmpFalse

CmpTrue:
        add ax, 1
        add si, 1
        add di, 1
        jmp LoopCmp

CmpFalse:
        add si, 1
        add di, 1

LoopCmp:
        cmp bl, '$'
        jne Comporation

        pop bp
        ret
        endp

EOP:
        mov ah, 09h			; say henlo
		mov dx, offset HenloUser
		int 21h

        xor ax, ax
        xor bx, bx

        call EnterPassword

        push offset Password
        push offset YourTry

        call CheckPassword
        
        pop ax
        pop ax

		mov ax, 4c00h
		int 21h

end		Start