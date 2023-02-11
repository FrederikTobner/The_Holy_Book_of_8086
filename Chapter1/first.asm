; Incredible Hello World program
org 0x100 ; Starting point of the com (command) file
start:
    mov bx, string ; Load the address of the string "Hello, world" into the register
repeat:
    mov al, [bx] ; Load a single byte intp the register al from the adress stroed in bx
    test al, al ; Test AL for zero
    je end ; jump if equal to end (jumps if al is zero)
    push bx ; Pushes the content stored in register bx onto the stack
    mov ah, 0x0e ; Load AH with code for terminal output
    mov bx, 0x000f ; BH is page (zero) Bl is color mode (graphic mode)
    int 0x10 ; Display a single letter
    pop bx ; Pop value from the stack and store it in register bx
    inc bx  ; Increment bx register
    jmp repeat ; Jump to repeat label

end:
    int 0x20 ; Exit to command line

string:
    db "Hello World!", 0x0 ; Null terminated "Hello World!" contstant
