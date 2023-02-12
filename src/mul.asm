;
; mul.asm
;
org 0x100
start:
    mov al, 0x04            ; AL = 4
    mov cl ,0x02            ; CL = 2 
    mul cl                  ; AL = AL * CL
    add al, 0x30            ; Conversion to ASCII
    call display_letter
    int 0x20                ; exit

; Include 8086 libary
%include "../src/library.asm"
