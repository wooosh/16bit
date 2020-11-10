; needs to be set by whoever is including fs.asm
drive_number dw 0

; args: buffer(8), sector(6), length(4)
; returns: 1 if error
fs_read_sectors:
    push bp
    mov bp, sp

    ; load sectors from disk
    mov ah, 0x2            ; fs op: read sector
    mov al, [bp+4]         ; number of sectors
    mov ch, 0x0            ; cylinder
    mov dh, 0x0            ; head
    mov dl, [drive_number] ; drive number (who could have guessed?)
    mov cl, [bp+6]         ; sector
    mov bx, [bp+8]         ; address to write contents to
    int 0x13

    xor ax, ax
    adc ax, 0 ; puts error (stored in carry flag) in ax
    pop bp
    ret 6