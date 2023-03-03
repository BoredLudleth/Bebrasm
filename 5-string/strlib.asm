.model tiny
.data
String: db "Ded, Henlo world!!!", '$'
String1: db "51268ABjhdasljkh$"
String2: db "ABC$"
.code
org 100h

locals @@

Start:
jmp MyProg
;---------------------------------
; Entry: SI - adress on string
; Exit: AX - counted symbols
; Expects: Length of string
; Destroy: AX, CX, SI
;---------------------------------
Strlen  proc
       push bp
       mov bp, sp
       mov di, [bp + 4]
       mov al, '$'
       mov cx, 0ffffh

       repne scasb
       mov ax, [bp + 4]
       sub di, ax
       mov ax, di 

        pop bp

        ret
		endp

;----------------------------------------------------
; Entry: SI - adress on string, AH - symbol to search
; Exit: AX - Pointer on first 'AH' in string
; Expects: String & Pointer
; Destroy: AX, CX, SI
;----------------------------------------------------
Memchr proc
       push bp
       mov bp, sp

       mov word ptr cx, [bp + 4]
       mov word ptr ax, [bp + 6]
       mov word ptr di, [bp + 8]
       
       repne scasb
       mov ax, di
       pop bp

       ret
	   endp

;----------------------------------------------------
; Entry: SI - adress on string, AH - symbol to search
; Exit: AX - Pointer on first 'AH' in string
; Expects: String & Pointer
; Destroy: AX, CX, SI
;----------------------------------------------------
Strchr proc
       push bp
       mov bp, sp

       mov word ptr di, [bp + 6]

       push di

       call Strlen

       mov word ptr cx, ax
       mov word ptr di, [bp + 6]
       mov word ptr ax, [bp + 4]

       repne scasb
       mov ax, di
       pop dx
       pop bp

       ret
	   endp

;-------------------------------------------------------------------------------
; Entry: SI - adress on string, ES - adress on copied string CX - number to copy
; Exit: copied string
; Expects: String & String 
; Destroy: AX, CX, SI
;-------------------------------------------------------------------------------
Memcpy proc
       push bp
       mov bp, sp

       mov word ptr si, [bp + 8]
       mov word ptr di, [bp + 6]
       mov word ptr cx, [bp + 4]

       rep movsb

       pop bp
        ret
		endp

;-------------------------------------------------------------------------------
; Entry: SI - adress on string, ES - adress on copied string
; Exit: copied string
; Expects: String & String 
; Destroy: AX, CX, SI
;-------------------------------------------------------------------------------
Strcpy proc
       push bp
       mov bp, sp

       mov word ptr si, [bp + 6]
       push si

       call Strlen

       mov word ptr cx, ax
       mov word ptr si, [bp + 6]
       mov word ptr di, [bp + 4]

       rep movsb

    pop dx
       pop bp
        ret
		endp

;-------------------------------------------------------------------------------
; Entry: SI - adress on string, ES - adress on copied string
; Exit: copied string
; Expects: String & String 
; Destroy: AX, CX, SI
;-------------------------------------------------------------------------------
Memcmp proc
       push bp
       mov bp, sp

       mov word ptr si, [bp + 8]
       mov word ptr di, [bp + 6]
       mov word ptr cx, [bp + 4]

       rep cmpsb

       cmp cx, 0
       je TRU

       mov ax, 0d
       jmp Ex
TRU:  mov ax, 1d

Ex:       pop bp
        ret
		endp

;-------------------------------------------------------------------------------
; Entry: SI - adress on string, ES - adress on copied string
; Exit: copied string
; Expects: String & String 
; Destroy: AX, CX, SI
;-------------------------------------------------------------------------------
Strcmp proc
       push bp
       mov bp, sp

       mov word ptr si, [bp + 6]
       push si

       call Strlen
       mov dx, ax

       mov word ptr di, [bp + 4]
       push di

       call Strlen

       cmp dx, ax
       jne Fls_t

       mov word ptr si, [bp + 6]
       mov word ptr di, [bp + 4]
       mov cx, ax

       rep cmpsb

       cmp cx, 0
       je TRU_t

Fls_t:       mov ax, 0d
       jmp Ext
TRU_t:  mov ax, 1d

Ext:      
        pop dx
        pop dx
        pop bp
        ret
		endp

;-------------------------------------------------------------------------------
; Entry: search di in si and return pointer
; Exit: copied string
; Expects: String & String 
; Destroy: AX, CX, SI
;-------------------------------------------------------------------------------
Strstr proc
       push bp
       mov bp, sp

       mov word ptr si, [bp + 6]
       push si

       call Strlen
       pop si
       push ax

       mov word ptr di, [bp + 4]
       push di
       call Strlen
       pop di
       push ax

       pop ax
       pop dx
       cmp dx, ax
       jl Not_F

       xor bx, bx

@@Next:mov cx, ax
       mov word ptr si, [bp + 6]
       add si, bx
       mov word ptr di, [bp + 4]
       rep cmpsb
       cmp cx, 0
       je Fou
       add bx, 1
       add cx, 1
       cmp bx, dx
       jae Not_f
       loop @@Next  

Not_F: mov ax, 0
       jmp EndStrstr
Fou:   mov ax, [bp + 6]
       add ax, bx
EndStrstr:

       pop bp

       ret 
       endp

MyProg:
;Test_Strlen: mov di, Offset String
;       push di
;       xor di, di
;       call Strlen

;Test_Memchr: mov di, Offset String
;             push di
;             xor ax, ax 
;             mov al, 'n'
;             push ax
;             mov cx, 15d
;             push cx
;            
;            xor si, si
;            xor ax, ax
;            xor cx, cx
;call Memchr

;Test_Strchr: mov di, Offset String
;             push di
;             mov al, '!'
;             push ax
;             xor ax, ax
;             xor di, di 
;call Strchr

;Test_Memcpy: mov si, Offset String
;             mov di, 0b800h
;             mov cx, 0003h
;
;             push si
;             push di
;             push cx
;
;             xor si, si
;             xor di, di
;             xor cx, cx
;call Memcpy

;Test_Strcpy: mov si, Offset String
;             mov di, 0b800h
;             push si
;             push di    
;
;             xor si, si
;             xor di, di
;call Strcpy

;Test_Memcmp: mov si, Offset String1
;             mov di, Offset String2
;             mov cx, 5d
;             push si
;             push di 
;             push cx   
;
;             xor si, si
;             xor di, di
;             xor cx, cx
;call Memcmp

;Test_Strcmp: mov si, Offset String1
;             mov di, Offset String2
;             push si
;             push di 
;
;             xor si, si
;             xor di, di
;call Strcmp

;Test_Strstr: mov si, Offset String1
;             mov di, Offset String2
;             push si
;             push di
;
;             xor si, si
;             xor di, di
;call Strstr

        mov ax, 4c00h
		int 21h
end		Start