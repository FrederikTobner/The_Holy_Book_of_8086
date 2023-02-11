; 8086 subroutine´libray

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

; Read key subroutine
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

; Display Number subroutine
display_number:
    mov dx, 0
    mov cx, 10
    div cx
    push dx
    cmp ax, 0
    je display_number_1
    call display_number
display_number_1:
    pop ax
    add al, '0'
    call display_letter
    ret

; Display Newline soubroutine
new_line:
    push ax
    mov al, 0x0a
    call display_letter
    mov al, 0x0d
    call display_letter
    pop ax
    ret

; Change display mode subroutine
change_display_mode:
    mov ax, 0x0003
    int 0x10
    ret

; Display string subroutine
display_string:
    mov al, [bx]
    test al, al            ; test if al is zero
    jz return
    push bx
    call display_letter
    pop bx
    inc bx
    jmp display_string
return:
    ret