[org 0x7c00]
mov ah, 0x0e
; Example 1
; mov al, text_data
; int 0x10
; Example 2
mov al, [text_data]
int 0x10
; Example 3
; mov bx, text_data
; add bx, 0x7c00
; mov al, [bx]
; int 0x10
; Example 4
; mov al, [0x7c1e]
; int 0x10

jmp $

text_data:
    db "X"

times 510-($-$$) db 0
dw 0xaa55
