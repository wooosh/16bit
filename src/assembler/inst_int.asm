inst_int:
  push si
  push inst_int_text
  call startswith
  cmp ax, 1
  je write_int
  ret
  write_int:
    add si, 4
    push si
    call read_int
    cmp cx, 0
    je err
    ;mov ax, 1

            push msg_start
    call serial_write_string

    add ax, 48

    push ax
    mov byte [bruh], al
    push bruh
    call serial_write_string
    pop ax

    mov byte [bruh], al
    push bruh
    call serial_write_string
    ;mov byte [bruh], 65
    ;push bruh
    ;call serial_write_string

    cli
    hlt

bruh dw 0, 0

inst_int_text db 'int ', 0