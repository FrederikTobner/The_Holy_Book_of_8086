;
; Incredible Hello World program
;
org 0x100                       ; Starting point of the com (command) file
start:
    mov si, string               ; SI walks forward from the start of the string
    mov di, string_end - 2       ; DI walks backward from the last character (skip null terminator)
reverse:
    cmp si, di                   ; Stop once the pointers meet or cross
    jge print
    mov al, [si]                 ; AL = character currently at SI
    xchg al, [di]                ; Swap: AL <-> character at DI
    mov [si], al                 ; Store DI's old character at SI
    inc si                       ; Move SI forward
    dec di                       ; Move DI backward
    jmp reverse                  ; Repeat until pointers cross

print:
    mov bx, string               ; Load the address of the string into BX for printing
repeat:
    mov al, [bx]                ; Load a single byte into the register al from the address stored in bx
    test al, al                 ; Test AL for zero
    je end                      ; jump if equal to end (jumps if al is zero)
    push bx                     ; Pushes the content stored in register bx onto the stack
    mov ah, 0x0e                ; Load AH with code for terminal output
    mov bx, 0x000f              ; BH is page (zero) Bl is color mode (graphic mode)
    int 0x10                    ; Display a single letter
    pop bx                      ; Pop value from the stack and store it in register bx
    inc bx                      ; Increment bx register
    jmp repeat                  ; Jump to repeat label

end:
    int 0x20                    ; Exit to command line

string:
    db "!dlroW olleH", 0x0      ; Null terminated string, reversed into normal order at runtime
string_end:

