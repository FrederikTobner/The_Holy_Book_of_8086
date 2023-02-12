;
; tictactoe.asm
;
org 0x0100

board:      equ 0x0300      ; Board is stored at memory location 0x0300

start:
    mov bx, board           ; Stores the memory adress where the board is located in the register bx
    mov cx, 9               ; Count 9 squares
    mov al, '1'             ; ASCII value representing the first square
init:                       ; Initializes the board
    mov [bx], al            ; 0x0300: 0x31, 0x32, ..., 0x39
    inc al                  ; Increment AL
    inc bx                  ; Increment BX
    loop init               ; Jmp back to init
game_loop:
    call show_board         ; Show the game board
    call find_line          ; Check for win condition

    call get_movement       ; Get input from player playing as 'X'
    mov byte [bx], 'X'

    call show_board         ; Show the game board
    call find_line          ; Check for win condition

    call get_movement       ; Get input from player playing as 'O'
    mov byte [bx], 'O'

    jmp game_loop           ; Loop back to the beginning

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

end:                        ; Ends the program execution
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

; Displays a single square
show_square:
    mov al, [bx]
    inc bx
    call display_letter
    ret

; Looks for a win condition
find_line:
check_horizontal1:
    mov al, [board]
    cmp al, [board+1]
    jne check_vertical1
    cmp al, [board+2]
    je won
check_vertical1:
    cmp al, [board+3]
    jne check_diagonal1
    cmp al, [board+6]
    je won
check_diagonal1:
    cmp al, [board+4]
    jne check_horizontal2
    cmp al, [board+8]
    je won
check_horizontal2:
    mov al, [board+3]
    cmp al, [board+4]
    jne check_horizontal3
    cmp al, [board+5]
    je won
check_horizontal3:
    mov al, [board+6]
    cmp al, [board+7]
    jne check_vertical2
    cmp al, [board+8]
    je won
check_vertical2:
    mov al, [board+1]
    cmp al, [board+4]
    jne check_vertical3
    cmp al, [board+7]
    je won
check_vertical3:
    mov al, [board+2]
    cmp al, [board+5]
    jne check_diagonal2
    cmp al, [board+8]
    je won
check_diagonal2:
    cmp al, [board+4]
    jne end_check
    cmp al, [board+6]
    je won
end_check:
    ret
won:                        ; at this point, AL contains the letter which made the line    
    call display_letter
    mov bx, message
    call display_string
    int 0x20                ; exit to command line

message:                    ; message that is displayed when a player has won the game
    db " won!", 0

; Include 8086 libary
%include "../src/library.asm"
