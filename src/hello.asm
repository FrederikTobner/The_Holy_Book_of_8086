;
; hello.asm
;
org 0x0100
start:
    mov ax, 0x0002              ; AH 0x00 Set color mode, AL 0x02  80x25x16 text (16 bit color mode)
    int 0x10                    ; Set color mode with value in AX

    mov ax, 0xb800              ; Screen is available at adress 0xb800
    mov ds, ax                  ; Set data segment register
    mov es, ax                  ; Set extra segment register

    cld                         ; clear DI/SI direction flag
    xor di, di                  ; clear direction flag
    mov ax, 0x1a48              ; H, foreground: light green
    stosw                       ; store ax in adress stored in DI, and increment DI by two
    mov ax, 0x1b45              ; E, foreground: light aqua
    stosw   
    mov ax, 0x1c4c              ; L, foreground: light red
    stosw
    mov ax, 0x1d4c              ; L, foreground: light purple
    stosw
    mov ax, 0x1e4f              ; O, foreground: light yellow
    stosw
    int 0x20