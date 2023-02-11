;
; tictactoe.asm
;
org 0x0100

board:      equ 0x0300      ; Board is stored at memory location 0x0300


start:
    mov bx, board           ; Stores the memory adress where the board is located in the register bx
    mov cx, 9           
    mov al, '1'
init:                        ; Initializes the board
    mov [bx], al            ; 0x0300: 0x31, 0x32, ..., 0x39
    inc al
    inc bx
    loop init
game_loop:
    call show_board
    call find_line

    call get_movement
    mov byte [bx], 'X'

    call show_board
    call find_line

    call get_movement
    mov byte [bx], 'O'

    jmp game_loop

get_movement:
    call read_key
    cmp al, 0x1b            ; Is Escape pressed?
    je end
    sub al, 0x31            ; al = al = '1'
    jc get_movement         ; if al < 1
    cmp al, 0x09
    jnc get_movement        ; if al > 9
    cbw                     ;expand AL to 16bit using AH
    mov bx, board
    add bx, ax
    mov al, [bx]
    cmp al, '@'             ; numbers should be smaller than '@'. 'X' or 'O' is larger
    jnc get_movement
    call new_line
    ret

end:
    int 0x20

; Shows the complete board
show_board:
    mov bx, board
    call show_row
    call show_div
    mov bx, board+3
    call show_row
    call show_div
    mov bx, board+6
    jmp show_row

; Displays a single row
show_row:
    call show_square
    mov al, '|'
    call display_letter
    call show_square
    mov al, '|'
    call display_letter
    call show_square
    call new_line
    ret

; Displays a divider
show_div:
    mov al, '-'
    call display_letter
    mov al, '+'
    call display_letter
    mov al, '-'
    call display_letter
    mov al, '+'
    call display_letter
    mov al, '-'
    call display_letter
    call new_line
    ret

; Dsiplays a single square
show_square:
    mov al, [bx]
    inc bx
    call display_letter
    ret

; Looks for a win condition
find_line:
    ; first horizontal line
    mov al, [board]
    cmp al, [board+1]
    jne b01
    cmp al, [board+2]
    je won
b01:
    ; leftmost vertical row
    cmp al, [board+3]
    jne b04
    cmp al, [board+6]
    je won
b04:
    ; first diagonal
    cmp al, [board+4]
    jne b05
    cmp al, [board+8]
    je won
b05:
    ; second horizontal
    mov al, [board+3]
    cmp al, [board+4]
    jne b02
    cmp al, [board+5]
    je won
b02:
    ; third horizontal
    mov al, [board+6]
    cmp al, [board+7]
    jne b03
    cmp al, [board+8]
    je won
b03:
    ; second vertical
    mov al, [board+1]
    cmp al, [board+4]
    jne b06
    cmp al, [board+7]
    je won
b06:
    ; rightmost vertical
    mov al, [board+2]
    cmp al, [board+5]
    jne b07
    cmp al, [board+8]
    je won
b07:
    ; second diagonal
    cmp al, [board+4]
    jne b08
    cmp al, [board+6]
    je won
b08:
    ret
won:
    ; at this point, AL contains the letter which made the line
    call display_letter
    mov bx, message
    call display_string
    int 0x20                ; exit to command line

message:
    db " won!", 0

%include "../src/library.asm"