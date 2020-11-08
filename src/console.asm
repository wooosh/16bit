org 0x7C00 ; add 0x7C00 to label addresses
bits 16

  ; set up serial
  mov ah, 0
  mov al, 0b11100011
  mov dx, 0
  int 0x14

  mov ah, 0x1
  mov al, 'h'
  int 0x14



  cli
  hlt

%include "src/lib/strings.asm"

a dq "hi"
b dq "hello"
c dq "hello"