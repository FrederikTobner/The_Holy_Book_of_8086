;
; Incredible FizzBuzz program
;

; Include 8086 library
%include "../lib/library.asm"

org 0x100                       ; Starting point of the com (command) file
start:
    mov bl, 0x01
loop:
    ; i < 101
    cmp bl, 0x65                ; Test BL for 101 (0x65)
    je end                      ; jump if equal to end (jumps if al is 101)
    mov al, bl                  ; Copy BL to AL for division 
    xor ah, ah                  ; Clear AH, div cl uses AX as dividend
    mov cl, 0x0F                ; Set CL to 15 for FizzBuzz
    div cl                      ; AL = AL / CL, remainder in AH
    test ah, ah                ; Check if remainder is 0
    jz print_fizzbuzz           ; If remainder is 0, print FizzBuzz
    mov al, bl                  ; Copy BL to AL for division
    xor ah, ah                  ; Clear AH, div cl uses AX as dividend
    mov cl, 0x03                ; Set CL to 3 for Fizz
    div cl                      ; AL = AL / CL, remainder in AH
    test ah, ah                ; Check if remainder is 0
    jz print_fizz               ; If remainder is 0, print Fizz
    mov al, bl                  ; Copy BL to AL for division
    xor ah, ah                  ; Clear AH, div cl uses AX as dividend
    mov cl, 0x05                ; Set CL to 5 for Buzz
    div cl                      ; AL = AL / CL, remainder in AH
    test ah, ah                 ; Check if remainder is 0
    jz print_buzz               ; If remainder is 0, print Buzz
    ; Print the number
    mov al, bl                  ; Copy BL to AL for printing
    xor ah, ah                  ; Clear AH, div cl uses AX as dividend
    call display_number
end_of_loop:
    call new_line; Display a new line
    ; i++
    inc bl
    jmp loop

print_fizzbuzz:
    push bx
    mov bx, f_con              ; Load the address of the string "Fizz" into the register
    call display_string
    mov bx, b_con              ; Load the address of the string "Buzz" into the register
    call display_string
    pop bx 
    jmp end_of_loop

print_fizz:
    push bx
    mov bx, f_con              ; Load the address of the string "Fizz" into the register
    call display_string
    pop bx
    jmp end_of_loop

print_buzz:
    push bx
    mov bx, b_con              ; Load the address of the string "Buzz" into the
    call display_string 
    pop bx
    jmp end_of_loop

end:
    int 0x20                    ; Exit to command line
f_con:
    db "Fizz", 0x0      ; Null terminated "Fizz" constant
b_con:
    db "Buzz", 0x0      ; Null terminated "Buzz" constant
