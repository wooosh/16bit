incbin "bin/bootloader.bin"


; file table format
; number of entries | dw
; entries           | see below

; file table entry format
; filename     | dq
; start sector | dw
; length       | dw

dw 1
; console file, entry
dq "console"
dw 3
dw 1

times (512*2)-($-$$) db 0

; actual file data
incbin "bin/console.bin"
times (512*3)-($-$$) db 0

; ABI
;   Arguments
;       All arguments are passed on the stack
;   Register preservation
;       All registers except ax, dx, and cx must be saved by the callee
;   Return value
;     Return value is placed in ax
