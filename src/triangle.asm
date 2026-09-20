;
; triangle.asm
;
; Classic 2D graphics demo: renders a filled triangle whose color slowly
; changes from edge to edge, using the same color trick as rectangle.asm
; and mandelbrot.asm
;

cpu 8086
org 0x0100

; scratch variables live in the invisible tail of VRAM, like in mandelbrot.asm/rectangle.asm
v_x:     equ 0xfa00
v_y:     equ 0xfa02
v_left:  equ 0xfa04
v_right: equ 0xfa06

TRI_X0:     equ 96                  ; left edge of the triangle's bounding box
TRI_Y0:     equ 36                  ; top edge of the triangle's bounding box
TRI_SIZE:   equ 128                 ; width/height of the bounding box (power of two)
TRI_APEX_X: equ TRI_SIZE / 2        ; local x of the apex (top of the triangle)

start:
    mov ax, 0x0013                ; 320x200, 256 color
    int 0x10

    call build_palette             ; red top, blue left edge, green right edge

    mov ax, 0xa000                 ; 0xa000 vram segment
    mov ds, ax
    mov es, ax

    cld                            ; clear DI/SI direction

    mov word [v_y], TRI_SIZE - 1

t0:
    mov ax, [v_y]
    shr ax, 1                      ; half the triangle's width at this row
    mov bx, TRI_APEX_X
    sub bx, ax
    mov [v_left], bx               ; leftmost local x on this row
    mov bx, TRI_APEX_X
    add bx, ax
    mov [v_right], bx              ; rightmost local x on this row

    mov bx, [v_right]
    mov [v_x], bx

t1:
    mov ax, [v_y]
    add ax, TRI_Y0                 ; absolute row on screen
    mov dx, 320
    mul dx                         ; row AX = row * 320
    mov bx, [v_x]
    add bx, TRI_X0                 ; absolute column on screen
    add ax, bx
    xchg ax, di                    ; DI <- AX (smaller than mov di, ax)

    mov ax, [v_y]                  ; row within the triangle
    ; AX = int(Y/8)*16, changes the color as Y goes from the apex to the base
    and ax, 0x78                    ; 0b_0111_1000
    shl ax, 1

    mov bx, [v_x]                  ; column within the triangle
    and bx, 0x78
    mov cl, 3
    shr bx, cl                     ; BX = BX / 8, changes the color as X goes from left edge to right edge
    add ax, bx
    stosb                          ; plot AL in DI

    mov ax, [v_x]
    cmp ax, [v_left]
    je t1_done
    dec word [v_x]
    jmp t1
t1_done:

    dec word [v_y]
    jns t0

    mov ah, 0x00
    int 0x16                       ; wait for key

    mov ax, 0x0002
    int 0x10

end:
    int 0x20

; Programs all 256 VGA DAC entries so that palette index (h << 4) | l, with
; h = row/8 and l = column/8 within the triangle, blends between red (apex),
; blue (left edge) and green (right edge) using barycentric interpolation.
build_palette:
    xor bx, bx                     ; bx = palette index 0..255

pb_loop:
    mov ax, bx
    and ax, 0x0f                   ; l = low nibble (column band)
    shl ax, 1
    shl ax, 1
    shl ax, 1                      ; ax = x = l * 8
    mov si, ax

    mov ax, bx
    mov cl, 4
    shr ax, cl                     ; h = high nibble (row band)
    shl ax, 1
    shl ax, 1
    shl ax, 1                      ; ax = y = h * 8
    mov di, ax

    ; R = clamp(64 - y/2, 0, 63), strongest at the apex (y = 0)
    mov ax, di
    shr ax, 1
    mov dx, 64
    sub dx, ax
    cmp dx, 63
    jbe pb_r_store
    mov dx, 63
pb_r_store:
    mov bp, dx                     ; bp = R

    ; G = clamp((2x + y - 128) >> 2, 0, 63), strongest at the right edge
    mov ax, si
    shl ax, 1
    add ax, di
    sub ax, 128
    mov cl, 2
    sar ax, cl
    cmp ax, 0
    jge pb_g_nonneg
    xor ax, ax
pb_g_nonneg:
    cmp ax, 63
    jbe pb_g_store
    mov ax, 63
pb_g_store:
    mov ch, al                     ; ch = G

    ; B = clamp((y - 2x + 128) >> 2, 0, 63), strongest at the left edge
    mov ax, si
    shl ax, 1
    mov dx, di
    sub dx, ax
    add dx, 128
    mov ax, dx
    mov cl, 2
    sar ax, cl
    cmp ax, 0
    jge pb_b_nonneg
    xor ax, ax
pb_b_nonneg:
    cmp ax, 63
    jbe pb_b_store
    mov ax, 63
pb_b_store:
    mov di, ax                     ; di = B

    mov dx, 0x3c8                  ; VGA DAC write index port
    mov ax, bx
    out dx, al
    mov dx, 0x3c9                  ; VGA DAC data port, expects R, G, B
    mov ax, bp
    out dx, al
    mov al, ch
    out dx, al
    mov ax, di
    out dx, al

    inc bx
    cmp bx, 256
    jne pb_loop
    ret
