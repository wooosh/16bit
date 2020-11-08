; args: a:word(6), b:word(4)
; returns: 1 when equal
strcmp:
    push bp
    mov bp, sp

    push si
    push di
    mov si, [bp+4]
    mov di, [bp+6]

    strcmp_loop:
        mov al, [si]
        cmp al, [di]
        jne strcmp_not_equal
        
        inc si
        inc di
        cmp al, 0
        jnz strcmp_loop ; if not null, goto loop
        

        ; strings are equal, return 1
        pop di
        pop si
        pop bp
        mov al, 1
        ret 4

    strcmp_not_equal:
        mov ah, 0x1
        mov dx, 0
        int 0x14

        pop di
        pop si
        pop bp
        mov al, 0
        ret 4
        