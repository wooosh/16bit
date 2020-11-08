org 0x7C00 ; add 0x7C00 to label addresses
bits 16

mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7C00

jmp 0x0:next ; set cs
next:

; set up serial channel 0
mov ah, 0          ; set serial operation to init channel
mov al, 0b11100011 ; set serial socket options
mov dx, 0          ; set serial channel to 0
int 0x14

push msg_started
call serial_write_string

push msg_loadft
call serial_write_string

call fs_load_ft
cmp ax, 1
je errorft

push msg_loadedft
call serial_write_string

cli
hlt

jmp 0x7E00 ; jump to the area we read from disk

errorft:
    push msg_errorft
    call serial_write_string
    cli
    hlt

%include "src/lib/strings.asm"
%include "src/lib/serial.asm"
%include "src/lib/fs.asm"

msg_started  db 'Bootloader Started', 0x0d, 0x0a, 0
msg_loadft   db 'Looking for file table', 0x0d, 0x0a, 0
msg_loadedft db 'Loaded file table', 0x0d, 0x0a, 0
msg_errorft  db 'File table error. Halting', 0x0d, 0x0a, 0




times 510-($-$$) db 0
dw 0AA55h ; bios signature

; memory map
; 0x00000500 - 0x00007BFF: stack, grows downward (30kb)
; 0x00007C00 - 0x00007DFF: bootsector (512b)
; 0x00007E00 - 0x0007FFFF: heap, grows downward (~33kb)
; 0x00010000 - 0x0007FFFF: heap, needs to be accessed with ES (458kb)