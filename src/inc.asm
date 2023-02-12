;
; inc.asm
;
org 0x100
start:
    mov al, 0x30
count1:
    call display_letter
    inc al
    cmp al, 0x39
    jne count1
count2:
    call display_letter
    dec al
    cmp al, 0x30
    jne count2

    int 0x20                    ; exit

%include "../src/library.asm"
