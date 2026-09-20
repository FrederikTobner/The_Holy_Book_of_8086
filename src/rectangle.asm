;
; rectangle.asm
;
; Classic 2D graphics demo: renders a filled rectangle whose color slowly
; changes from each edge to the other, similar to mandelbrot.asm
;

cpu 8086
org 0x0100

; 320x200 = 64,000 byte VRAM is used from 0x0000
v_x:    equ 0xfa00
v_y:    equ 0xfa02

RECT_X0:   equ 96                   ; left edge of the rectangle on screen
RECT_Y0:   equ 36                   ; top edge of the rectangle on screen
RECT_SIZE: equ 128                  ; width/height of the rectangle (power of two)

start:
    mov ax, 0x0013                  ; 320x200, 256 color
    int 0x10

    call build_palette              ; blue/red/cyan/yellow gradient across the corners

    mov ax, 0xa000                  ; 0xa000 vram segment
    mov ds, ax
    mov es, ax

    cld                             ; clear DI/SI direction

    mov word [v_y], RECT_SIZE - 1

r0:
    mov word [v_x], RECT_SIZE - 1

r1:
    mov ax, [v_y]
    add ax, RECT_Y0                 ; absolute row on screen
    mov dx, 320
    mul dx                          ; row AX = row * 320
    mov bx, [v_x]
    add bx, RECT_X0                 ; absolute column on screen
    add ax, bx
    xchg ax, di                     ; DI <- AX (smaller than mov di, ax)

    mov ax, [v_y]                   ; row within the rectangle
    ; AX = int(Y/8)*16, changes the color as Y goes from top edge to bottom edge
    and ax, 0x78                    ; 0b_0111_1000
    shl ax, 1

    mov bx, [v_x]                   ; column within the rectangle
    and bx, 0x78
    mov cl, 3
    shr bx, cl                      ; BX = BX / 8, changes the color as X goes from left edge to right edge
    add ax, bx
    stosb                           ; plot AL in DI

    dec word [v_x]
    jns r1

    dec word [v_y]
    jns r0

    mov ah, 0x00
    int 0x16                        ; wait for key

    mov ax, 0x0002
    int 0x10

end:
    int 0x20

; Programs all 256 VGA DAC entries so that palette index (h << 4) | l, with
; h = row/8 and l = column/8 within the rectangle, blends blue (top-left) to
; red (top-right) to cyan (bottom-left) to yellow (bottom-right).
build_palette:
    xor bx, bx                     ; bx = palette index 0..255

pb_loop:
    mov ax, bx
    and ax, 0x0f                   ; l = column band (low nibble)
    shl ax, 1
    shl ax, 1                      ; ax = l * 4, red rises left to right
    mov si, ax                     ; si = R

    mov ax, bx
    mov cl, 4
    shr ax, cl                     ; h = row band (high nibble)
    shl ax, 1
    shl ax, 1                      ; ax = h * 4, green rises top to bottom
    mov di, ax                     ; di = G

    mov dx, 0x3c8                  ; VGA DAC write index port
    mov ax, bx
    out dx, al
    mov dx, 0x3c9                  ; VGA DAC data port, expects R, G, B
    mov ax, si
    out dx, al
    mov ax, di
    out dx, al
    mov ax, 63
    sub ax, si                     ; blue fades out left to right
    out dx, al

    inc bx
    cmp bx, 256
    jne pb_loop
    ret
