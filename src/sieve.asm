;
; sieve.asm
;
org 0x100

table equ 0x8000
table_size equ 0x1000
start:
    mov bx, table
    mov cx, table_size
    mov al, 0
pl:
    mov [bx], al            ; write AL into adress pointed to by bx
    inc bx                  ; increment bx
    loop pl                 ; loop back to p1 if non-zero
    mov ax, 2               ; Store 2 in register AX
p2: 
    mov bx, table           ; Store table adress in Register BX
    add bx, ax              ; BX += AX
    cmp byte [bx], 0        ; Is it a prime number?
    jne p3                  ; If not jump tp p3
    push ax
    call display_number
    mov al, 0x2c
    call display_letter
    pop ax
    mov bx, table
p4:
    add bx, ax
    cmp bx, table+table_size
    jnc p3
    mov byte [bx], 1
    jmp p4
p3:
    inc ax 
    cmp ax, table_size
    jne p2

    int 0x20                ; exit

%include "../src/library.asm"