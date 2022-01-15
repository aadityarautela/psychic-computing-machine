mov ah, 0x0e ; enabling tty mode
mov al, 'H'
int 0x10 ; interrupt for video
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; l is still in al
mov al, 'o'
int 0x10
mov al, '!'
int 0x10
int 0x10

jmp $ ; infinite loop

times 510 - ($-$$) db 0
dw 0xaa55