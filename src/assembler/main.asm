; Memory layout
; DS/ES:
;   Assembler executable (static size)
;   File read from disk (grows upward)
;   Label data (grows downward from end of segment)
; FS - output file

org 0x7E00
bits 16
  ; run tests on libs
  push msg_tests_start
  call serial_write_string
  
  call strings_test
  
  push msg_tests_end
  call serial_write_string 

  ; actual assembly code
  push msg_start
  call serial_write_string
  
  push word 1
  call serial_write_word

  ; set up segments
  mov ax, 0x1000
  mov fs, ax

  mov si, file_start
  xor di, di ; set at beginning of file register

  ; main loop, reads instructions and encodes them
  read_next:
      call inst_int

      ; doesn't match any instructions
      push msg_unknown_instruction
      call serial_write_string
      push si
      call serial_write_string

  next:
  cli
  hlt

err:
  push msg_err
  call serial_write_string
  hlt
  cli

%include "src/lib/serial.asm"
%include "src/lib/strings.asm"

%include "src/lib/strings_test.asm"

%include "src/assembler/inst_int.asm"

msg_tests_start db "[INFO] Starting tests", 0x0a, 0x0d, 0
msg_tests_end   db "[INFO] Tests ending", 0x0a, 0x0d, 0

msg_start db "[INFO] Started assembler", 0x0a, 0x0d, 0
msg_err   db "[ERROR] Unknown error while assembling", 0x0a, 0x0d, 0
msg_unknown_instruction db "[ERROR] Unknown Instruction", 0x0a, 0x0d, 0

file_idx dw 0
out_idx dw 0

; we use this to signify the end of our code
file_start:
db "int 65", 0