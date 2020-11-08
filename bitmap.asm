bm_x_stop dw 0 ; x + width
bm_y_stop dw 0 ; y + height
draw_bitmap:
    %push
    %stacksize large
    %arg bitmap_address:word, x:word, y:word, width:word, height:word

    push bp
    mov bp, sp

    push si
    mov si, [bitmap_address] ; set si to bitmap location

    mov dx, [y] ; set cursor y to y

    ; set bm_x_stop to x + width
    mov ax, [x] ; put x in ax
    add ax, [width]  ; add width to ax
    mov [bm_x_stop], ax

    ; set bm_y_stop to y + height
    mov ax, [y] ; put y in ax
    add ax, [height] ; put height in ax
    mov [bm_y_stop], ax

    mov ah, 0x0c ; set graphics op to draw pixel

    .for_y:
        mov cx, [x] ; set cursor x to first column
        .for_x:
            mov al, [si] ; read bitmap
            int 0x10     ; tell bios to draw pixel

            inc si ; move forward one pixel in bitmap
            inc cx ; move cursor forward one

            cmp cx, [bm_x_stop]
            jne .for_x
        inc dx ; move one row down
        cmp dx, [bm_y_stop]
        jne .for_y

    pop si
    pop bp
    ret 10
    %pop