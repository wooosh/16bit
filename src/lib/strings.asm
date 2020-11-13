; args: a:word(6), b:word(4)
; returns: ax=1 when equal, ax=0 if not
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
        mov ax, 1
        jmp strcmp_ret

    strcmp_not_equal:
        mov ax, 0

    strcmp_ret:
        pop di
        pop si
        pop bp
        ret 4

; args: a:word(6), prefix:word(4)
; returns: ax=1 when startswith, ax=0 if not
startswith:
    push bp
    mov bp, sp

    push si
    push di
    mov si, [bp+4] ; prefix
    mov di, [bp+6] ; a

    startswith_loop:
        mov al, [si]
        cmp al, 0
        je startswith_equal

        cmp al, [di]
        jne startswith_not_equal
        
        inc si
        inc di
        jmp startswith_loop

    startswith_equal:
        ; strings are equal, return 1
        mov ax, 1
        jmp startswith_ret

    startswith_not_equal:
        mov ax, 0

    startswith_ret:
        pop di
        pop si
        pop bp
        ret 4

; args: buffer:word(4)
; returns: if success cx=1 and ax=num, otherwise cx=0
read_int:
    push bp
    mov bp, sp

    push si
    mov si, [bp+4]

    xor ax, ax ; set num to start at zero
    xor cx, cx ; cx will be set to one if we read atleast one character

    mov dl, 10 ; used for place value
    read_int_loop:
        ; check if it is a number 0-9 (ascii 48-57)
        cmp byte [si], 48
        jb read_int_ret
        cmp byte [si], 57
        jg read_int_ret

        ; each character we read increase the place value 
        mul dl

        ; add to counter and convert from ascii to decimal
        add ax, [si]
        sub ax, 48

        mov cx, 1
        inc si

        jmp read_int_loop

    read_int_ret:
        pop si
        pop bp
        ret 2

; args: byte(4)
; returns: ax=ascii version of input byte (eg "f0")  
get_hex_byte:
    push bp
    mov bp, sp
    push bx

    xor bx, bx
    mov cx, [bp+4]
    xor ch, ch

    ; first character
    ror cx, 4
    mov bl, cl
    mov al, [nibble_hex_table+bx]
    
    ; second character
    shr ch, 4
    mov bl, ch
    mov ah, [nibble_hex_table+bx]

    pop bx
    pop bp
    ret 2

nibble_hex_table db '0123456789ABCDEF'

; args: byte(6), buffer(4)
get_hex_word:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp+4]

    mov cx, [bp+6]
    push cx
    call get_hex_byte
    mov [bx+2], ax

    mov cx, [bp+6]
    shr cx, 8
    push cx
    call get_hex_byte
    mov [bx], ax
    
    pop bx
    pop bp
    ret 2