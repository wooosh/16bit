; file table format
; number of entries | dw
; entries           | see below

; file table entry format
; filename     | dq
; start sector | dw
; length       | dw

section .bss
fs_num_files  resw 1
fs_file_table resb 510

section .text
; returns: 1 if error
; loads file table
fs_load_ft:
    push fs_file_table
    push 1
    push 1
    call fs_read_sector
    ret

; args: buffer(8), sector(6), length(4)
; returns: 1 if error
fs_read_sector:
    push bp
    mov bp, sp

    ; load sectors from disk
    mov ah, 0x2 ; fs op: read sector
    mov al, [bp+4] ; number of sectors
    mov ch, 0x0 ; cylinder
    mov dh, 0x0 ; head
    mov cl, [bp+6] ; sector
    mov bx, [bp+8] ; write after boot sector
    int 0x13

    xor ax, ax
    adc ax, 0 ; puts error (stored in carry flag) in ax
    pop bp
    ret 6

; args: filename(6), file_entry(4)
; returns: 1 if error
; populates file_entry with the following format
;   start sector | dw
;   length       | dw
;
; if filename is not found, 1 is returned
fs_get_file:
    push bp
    mov bp, sp

    fs_get_file_loop:
        strcmp

    pop bp
    ret 4