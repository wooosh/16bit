; Segment layout
; ES - used to store file data read from the disk
; FS - encoded instructions
; GS - label data

org 0x7E00
bits 16
  push msg_start
  call serial_write_string
  
  ; set up segments
  mov ax, 0x1000  
  mov es, ax
  
  add ax, 0x1000
  mov fs, ax

  add al, 0x1000
  mov gs, ax

  cli
  hlt

%include "src/lib/serial.asm"

msg_start db "[INFO] Started assembler", 0x0a, 0x0d, 0