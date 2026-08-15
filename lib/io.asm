; 8086 I/O library

; This library provides basic I/O functions for the 8086 assembly language. 
; It includes subroutines for printing letters, numbers, strings, reading keys, and changing display modes.

; Subroutine to print a single letter stored in AL
print_letter:
    ; Store register contents
    push ax
    push bx 
    push cx
    push dx
    push si 
    push di

    mov ah, 0x0e        ; Load AH with code for terminal output
    mov bx, 0x000f      ; BH is page (zero) Bl is color mode (graphic mode)
    int 0x10            ; Display a single letter
    
    ; Restore register contents
    pop di 
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

    ret                 ; Return from subroutine

; Sobroutine to read a single key press and return the ASCII code in AL
read_key:
    ; Store register contents
    push bx 
    push cx
    push dx
    push si 
    push di

    mov ah, 0x00        ; Load AH with code for terminal output
    int 0x16            ; Read a sigle character
    
    ; Restore register contents
    pop di 
    pop si
    pop dx
    pop cx
    pop bx

    ret                 ; Return from subroutine

; Sobroutine to print a number stored in AX
print_number:
    mov dx, 0
    mov cx, 10
    div cx
    push dx
    cmp ax, 0
    je print_single_digit
    call print_number
print_single_digit:
    pop ax
    add al, '0'
    call print_letter
    ret

; Sobroutine to print a new line
print_new_line:
    push ax
    mov al, 0x0a
    call print_letter
    mov al, 0x0d
    call print_letter
    pop ax
    ret

; Subroutine to print a string stored at the address in BX
print_string:
    mov al, [bx]
    test al, al            ; test if al is zero
    jz return_from_print_string
    push bx
    call print_letter
    pop bx
    inc bx
    jmp print_string
return_from_print_string:
    ret
    