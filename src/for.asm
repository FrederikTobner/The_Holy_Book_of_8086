;
; Incredible For loop program
;
; Include 8086 library
%include "../lib/library.asm"
org 0x100                       ; Starting point of the com (command) file
start:
    mov ax, 0x01
loop:
    ; i < 101
    cmp al, 0x65                ; Test AL for 101 (0x65)
    je end                      ; jump if equal to end (jumps if al is 101)
    push ax
    call display_number
    pop ax
    call new_line; Display a new line
    ; i++
    inc al
    jmp loop

end:
    int 0x20                    ; Exit to command line
