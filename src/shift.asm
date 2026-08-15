;
; shift.asm
;
; Include 8086 libary
%include "../lib/io.asm"
org 0x100
start:
    mov al, 0x02            ; AL = 2
    shl al ,0x01            ; AL >>= 1 
    add al, 0x30            ; Conversion to ASCII
    call print_letter
    int 0x20                ; exit
