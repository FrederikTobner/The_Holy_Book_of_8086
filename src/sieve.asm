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
    mov [bx], al                ; write AL into adress pointed to by bx
    inc bx                      ; increment bx
    loop pl                     ; loop back to p1 if non-zero
    mov ax, 2                   ; Store 2 in register AX
p2:     
    mov bx, table               ; Store table adress in Register BX
    add bx, ax                  ; BX += AX
    cmp byte [bx], 0            ; Is it a prime number?
    jne p3                      ; If not jump tp p3
    push ax                     ; Pushes the value stored in AX on the stack
    call display_number         ; Displays the number
    mov al, 0x2c                ; Store ASCII code for ',' in al
    call display_letter         ; Display ','
    pop ax                      ; Restore register content
    mov bx, table               ; Store table adress in Register BX 
p4: 
    add bx, ax                  ; Increment bx by ax
    cmp bx, table+table_size    ; Is bx out of bounds ?
    jnc p3                      ; If this is the case jump to p3
    mov byte [bx], 1            ; Store 1 at the adress that is stored in bx
    jmp p4                      ; jmp to p4
p3:
    inc ax                      ; incrment AX
    cmp ax, table_size          ; Compare AX with table size
    jne p2                      ; If they are not equal jump to p2

    int 0x20                    ; exit

; Include 8086 libary
%include "../src/library.asm"   