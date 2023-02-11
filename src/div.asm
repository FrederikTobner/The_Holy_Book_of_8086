;
; div.asm
;
org 0x100
start:
    mov al, 0x64            ; AL = 100
    mov cl ,0x21            ; CL = 33 
    div cl                  ; AL = AL / CL
    add al, 0x30            ; Conversion to ASCII
    call display_letter
    int 0x20                ; exit

; Display letter subroutine
; Displays the charater contained in AL
display_letter:
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
