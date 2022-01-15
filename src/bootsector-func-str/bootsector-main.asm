[org 0x7c00]
mov bx, PSYCHIC
call print
call print_newline
mov bx, COMPUTING
call print
call print_newline
mov bx, MACHINE
call print
call print_newline
mov dx, 0xdead
call print_hex
call print_newline
mov dx, 0xbeef
call print_hex
call print_newline
jmp $

%include "bootsector-print-str.asm"
%include "bootsector-print-hex.asm"

; Data
PSYCHIC:
    db "Psychic",0
COMPUTING:
    db "Computing",0
MACHINE:
    db "Machine",0

times 510-($-$$) db 0
dw 0xaa55