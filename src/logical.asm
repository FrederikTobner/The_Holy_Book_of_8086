;
; logical.asm
;
org 0x100
start:
    mov al, 0x32            ; AL = 50
    and al ,0x0f            ; AL >>= 1 
    add al, 0x30            ; Conversion to ASCII
    call display_letter
    int 0x20                ; exit

; Include 8086 libary
%include "../src/library.asm"
