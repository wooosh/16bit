text_color db 0xf

; writes a string of uppercase chars
write_string:
    %push
    %stacksize large
    %arg str:word, x2:word, y2:word

    push bp
    mov bp, sp

    push si
    mov si, [str]
    mov cx, [x2]
    cld
    .loop:
        xor ax, ax
        lodsb
        test al, al
        jz .done
        push cx
        call_ write_char, ax, cx, word [y]
        pop cx
        add cx, 6
        
        jmp .loop
    .done:

    pop si
    pop bp
    ret
    %pop

; writes an uppercase character
; TODO: lowercase
; TODO: numbers and special chars
; TODO: skip unprintable chars
write_char:
    %push
    %stacksize large
    %arg char:word, x:word, y:word

    push bp
    mov bp, sp

    ;sub word [char], 65
    mov ax, word [char]
    sub ax, 65
    mov bx, 5*6
    mul bx
    add ax, font

    call_ draw_bitmap, ax, word [x], word [y], 5, 6, word [text_color]

    pop bp
    ret 6
    %pop

font:
; A
db 0,1,1,1,0
db 1,0,0,0,1
db 1,0,0,0,1
db 1,1,1,1,1
db 1,0,0,0,1
db 1,0,0,0,1
; B
db 1,1,1,1,0
db 1,0,0,0,1
db 1,1,1,1,0
db 1,0,0,0,1
db 1,0,0,0,1
db 1,1,1,1,0
; C
db 0,1,1,1,0
db 1,0,0,0,1
db 1,0,0,0,0
db 1,0,0,0,0
db 1,0,0,0,1
db 0,1,1,1,0
; D
db 1,1,1,1,0
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,1,1,1,0
; E
db 1,1,1,1,1
db 1,0,0,0,0
db 1,1,1,1,0
db 1,0,0,0,0
db 1,0,0,0,0
db 1,1,1,1,1
; F
db 1,1,1,1,1
db 1,0,0,0,0
db 1,1,1,1,0
db 1,0,0,0,0
db 1,0,0,0,0
db 1,0,0,0,0
; G
db 0,1,1,1,1
db 1,0,0,0,0
db 1,0,1,1,1
db 1,0,0,0,1
db 1,0,0,0,1
db 0,1,1,1,0
; H
db 1,0,0,0,1
db 1,0,0,0,1
db 1,1,1,1,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
; I
db 1,1,1,1,1
db 0,0,1,0,0
db 0,0,1,0,0
db 0,0,1,0,0
db 0,0,1,0,0
db 1,1,1,1,1
; J
db 0,0,1,1,1
db 0,0,0,1,0
db 0,0,0,1,0
db 0,0,0,1,0
db 1,0,0,1,0
db 0,1,1,0,0
; K
db 1,0,0,0,1
db 1,0,0,1,0
db 1,0,1,0,0
db 1,1,0,1,0
db 1,0,0,0,1
db 1,0,0,0,1
; L
db 1,0,0,0,0
db 1,0,0,0,0
db 1,0,0,0,0
db 1,0,0,0,0
db 1,0,0,0,0
db 1,1,1,1,1
; M
db 1,1,0,1,1
db 1,0,1,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
; N
db 1,1,0,0,1
db 1,0,1,0,1
db 1,0,0,1,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
; O
db 0,1,1,1,0
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 0,1,1,1,0
; P
db 1,1,1,1,0
db 1,0,0,0,1
db 1,1,1,1,0
db 1,0,0,0,0
db 1,0,0,0,0
db 1,0,0,0,0
; Q
db 0,1,1,1,0
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,1,0,1
db 1,0,0,1,0
db 0,1,1,0,1
; R
db 1,1,1,1,0
db 1,0,0,0,1
db 1,1,1,1,0
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
; S
db 0,1,1,1,1
db 1,0,0,0,0
db 0,1,1,1,0
db 0,0,0,0,1
db 0,0,0,0,1
db 1,1,1,1,0
; T
db 1,1,1,1,1
db 0,0,1,0,0
db 0,0,1,0,0
db 0,0,1,0,0
db 0,0,1,0,0
db 0,0,1,0,0
; U
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 0,1,1,1,0
; V
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,0,0,1
db 0,1,0,1,0
db 0,1,0,1,0
db 0,0,1,0,0
; W
db 1,0,0,0,1
db 1,0,0,0,1
db 1,0,1,0,1
db 1,0,1,0,1
db 1,0,1,0,1
db 0,1,0,1,0
; X
db 1,0,0,0,1
db 0,1,0,1,0
db 0,0,1,0,0
db 0,1,0,1,0
db 1,0,0,0,1
db 1,0,0,0,1
; Y
db 1,0,0,0,1
db 0,1,0,1,0
db 0,0,1,0,0
db 0,0,1,0,0
db 0,0,1,0,0
db 0,0,1,0,0
; Z
db 1,1,1,1,1
db 0,0,0,1,0
db 0,0,1,0,0
db 0,1,0,0,0
db 1,0,0,0,0
db 1,1,1,1,1