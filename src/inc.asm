;
; inc.asm
;
org 0x100
start:
    mov al, 0x30
count_up:
    call display_letter
    inc al
    cmp al, 0x39
    jne count_up
count_down:
    call display_letter
    dec al
    cmp al, 0x30
    jne count_down

    int 0x20                    ; exit

%include "../src/library.asm"
