;
; Testing Input under 8086/8088
;
org 0x100
start:
    mov ah, 0x00    ; Keyboard read
    int 0x16        ; Call the BIOS to read it
    cmp al, 0x1b    ; ESC key pressed ?
    je exit_to_cmd  ; If yes exit
    mov ah, 0x0e    ; Load ah with code for terminal output
    mov bx, 0x000f  ; BH is page (zero) Bl is color mode (graphic mode)
    int 0x10        ; Displays a single letter
    jmp start       ; Jump to start label

exit_to_cmd:
    int 0x20        ; Exit to command line