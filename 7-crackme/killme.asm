.286
.model tiny
.data
HenloUser: db "Henlo, enter password, to get success!", 0ah,'$'
Congratulations: db "SUCCESS! Thanks for using our verifying system", '$'
Loser: db "Sorry, it's not your password. We apologize", '$'
Password: db 9, "password", '$'        ;length of password, password
YourTry: db 254d                       ;your max, length of read password, '$...'
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
        add di, 1

        push si
        call HashPassword
        pop si

        mov bx, ax
        xor ax, ax

        push di
        call HashPassword
        pop di

        cmp ax, bx
        je SUCCSESS
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

HashPassword    proc
    push bp
    mov bp, sp
    mov si, [bp+4]
    xor ax, ax
    xor dx, dx

    mov cl, ds:[si]
    mov al, cl
    add si, 1
LoopHash:
    mov dl, ds:[si]
    add si, 1
    add ax, dx
    add ax, cx
    loop LoopHash

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