org 0x7C00 ; add 0x7C00 to label addresses
bits 16

mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7C00

jmp 0x0:next ; set cs
next:

; load sectors from disk
mov ah, 0x2
mov al, 0x2 ; number of sectors
mov ch, 0x0 ; cylinder
mov dh, 0x0 ; head
mov cl, 0x2 ; sector
mov bx, main
int 0x13

jmp main

times 510-($-$$) db 0
dw 0AA55h ; bios signature

%macro pusha 2-*
  %rep %0
  %rotate -1
  push %1
  %endrep
%endmacro

%macro call_ 2+
  pusha %2
  call %1
%endmacro

main:
  ; set up serial
  mov ah, 0
  mov al, 0b11100011
  mov dx, 0
  int 0x14

  ; send 'h' over serial
  mov ah, 0x1
  mov al, 'h'
  int 0x14

  mov ah, 0   ;Set display mode
  mov al, 13h ;13h = 320x200, 256 colors
  int 0x10

  call_ write_string, message, 10, 10

  cli
  hlt

  message db "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0

%include "bitmap.asm"
%include "font.asm"

times 32768-($-$$) db 0





;call_ draw_bitmap, font, 10, 30, 5, 6




; memory map
; 0x00000500 - 0x00007BFF: stack, grows downward (30kb)
; 0x00007C00 - 0x00007DFF: bootsector (512b)
; 0x00007E00 - 0x0007FFFF: heap, grows downward (~33kb)
; 0x00010000 - 0x0007FFFF: unused because, needs segment registers set to access (458kb)