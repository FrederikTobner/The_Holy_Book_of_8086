;
; guess.asm
;
org 0x100
start:
    in al, (0x40)               ; Read the timer counter chip
    and al, 0x07                ; Mask bits so the values become 0-7
    add al, 0x30                ; Conversion to ASCII
    mov cl, al                  ; Save al to cl
game_loop:
    mov al, 0x3f                ; Store ASCII question mark value in register al
    call display_letter         ; Display AL
    call read_key               ; Read character and store it in AL
    cmp al, cl                  ; Compare input with secret number
    jne game_loop               ; If the numbers where not equal jump keep asking for input
    call display_letter         ; Display number
    ; Display Happy face
    mov al, 0x3a
    call display_letter         
    mov al, 0x29
    call display_letter

    int 0x20                    ; exit

; Include 8086 libary
%include "../src/library.asm"