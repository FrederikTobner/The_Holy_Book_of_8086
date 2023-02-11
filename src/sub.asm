;
; sub.asm
;
org 0x100
start:
    mov al, 0x04            ; AL = 4
    sub al ,0x03            ; AL -= 3 
    add al, 0x30            ; Conversion to ASCII
    call display_letter
    int 0x20                ; exit

%include "../src/library.asm"