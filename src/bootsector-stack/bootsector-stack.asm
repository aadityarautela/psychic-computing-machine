mov ah, 0x0e

mov bp, 0x8000  ; setting base pointer of a stack
mov sp, bp  ; stack grows downwards

; pushing values onto the stack
push 'P'
push 'C'
push 'M'

pop bx  ; popping 16bit value 
mov al, bl  ; 8 bit char copy into ax
int 0x10
pop bx  ; popping 16bit value 
mov al, bl  ; 8 bit char copy into ax
int 0x10

mov al, [0x8000-0x2]
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55