; args: str:word(4)
serial_write_string:
    push bp
    mov bp, sp
    
    push si
    mov si, [bp+4]
    
    mov dx, 0x0 ; set serial channel 0
    write_string_loop:
        mov ah, 0x1 ; set serial operation to write character
        mov al, [si]
        cmp al, 0
        jz write_string_end ; end if we are on a null terminator
        
        int 0x14    
        inc si

        jmp write_string_loop

    write_string_end:
    pop si
    pop bp
    ret 2

