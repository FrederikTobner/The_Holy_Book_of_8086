;
; inc.asm
;

%include "../lib/io.asm"

org 0x100
start:
    mov al, 0x30
count_up:
    call print_letter
    inc al
    cmp al, 0x39
    jne count_up
count_down:
    call print_letter
    dec al
    cmp al, 0x30
    jne count_down

    int 0x20                    ; exit
