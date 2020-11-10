incbin "bin/bootloader.bin"
incbin "bin/assembler.bin"
times (512*2)-($-$$) db 0

; misc docs

; memory map
; 0x00000500 - 0x00007BFF: stack, grows downward (30kb)
; 0x00007C00 - 0x00007DFF: bootsector (512b)
; 0x00007E00 - 0x0000FFFF: whatever the bootloader decides to load (~33kb)
; 0x00010000 - 0x0007FFFF: general use memory, needs ES to be accessed (458kb)

; typical segment set up
; segment | segment value | actual address
; ES      | 0x1000        | 0x10000
; FS      | 0x2000        | 0x20000
; GS      | 0x3000        | 0x30000
;
; which can be achieved with the following assembly
;   mov al, 0x1000
;   mov es, al
  
;   add al, 0x1000
;   mov fs, al

;   add al, 0x1000
;   mov gs, al

; ABI
;   Arguments
;       All arguments are passed on the stack
;   Register preservation
;       All registers except ax, dx, and cx must be saved by the callee
;   Return value
;     Return value is placed in ax
