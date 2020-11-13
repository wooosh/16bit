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
    push ax
    push hex_word_buf
    call get_hex_word
    push hex_word_buf
    call serial_write_string

    cli
    hlt

hex_word_buf db 0,0,0,0,0
inst_int_text db 'int ', 0