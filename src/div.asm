;
; div.asm
;
org 0x100
start:
    mov al, 0x64                ; AL = 100
    mov cl ,0x21                ; CL = 33 
    div cl                      ; AL = AL / CL
    add al, 0x30                ; Conversion to ASCII
    call display_letter
    int 0x20                    ; exit

; Include 8086 libary
%include "../src/library.asm"