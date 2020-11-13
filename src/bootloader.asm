org 0x7C00 ; add 0x7C00 to label addresses
bits 16

mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7C00

jmp 0x0:next ; set cs
next:

mov [drive_number], dl

; set up serial channel 0
mov ah, 0          ; set serial operation to init channel
mov al, 0b11100011 ; set serial socket options
mov dx, 0          ; set serial channel to 0
int 0x14

push msg_started
call serial_write_string

push msg_load_os
call serial_write_string

push 0x7E00 ; Read program into the area after the boot sector
push 2      ; Start read right after boot sector
push 3      ; Read two sectors
call fs_read_sectors
cmp ax, 1
je error_fs

push msg_loaded_os
call serial_write_string

push msg_jmp_os
call serial_write_string

jmp 0x7E00 ; jump to the area we read from disk

error_fs:
    push msg_error_fs
    call serial_write_string
    cli
    hlt

%include "src/lib/serial.asm"
%include "src/lib/fs.asm"


msg_started   db '[INFO] Bootloader Started', 0x0d, 0x0a, 0
msg_load_os   db '[INFO] Loading OS into memory...', 0x0d, 0x0a, 0
msg_loaded_os db '[INFO] Loaded OS into memory', 0x0d, 0x0a, 0
msg_jmp_os    db '[INFO] Exiting bootloader, Entering OS', 0x0d, 0x0a, 0
msg_error_fs  db '[ERROR] Filesystem error. Halting', 0x0d, 0x0a, 0


times 510-($-$$) db 0
dw 0AA55h ; bios signature