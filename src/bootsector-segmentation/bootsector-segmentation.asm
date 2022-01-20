mov ah, 0x0e

mov al, [text_data]
int 0x10

mov bx, 0x7c0
mov ds, bx
mov al, [text_data]
int 0x10

mov al, [es:text_data]
int 0x10

mov bx, 0x7c0
mov es, bx
mov al, [es:text_data]
int 0x10

jmp $

text_data:
    db "P"

times 510-($-$$) db 0
dw 0xaa55