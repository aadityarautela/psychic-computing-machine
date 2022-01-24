print_hex:
    pusha
    mov cx, 0   ; index variable

hex_loop:
    cmp cx, 4
    je end
    mov ax, dx  ; dx is our working variable
    and ax, 0x000f  ; getting the last digit of hex var
    add al, 0x30    ; converting to ascii
    cmp al, 0x39    ; if greater than '9', change to 'a' to 'f'
    jle subroutine
    add al, 7
subroutine:
    mov bx, output_hex + 5  ; 0x0000 + 0
    sub bx, cx  ; cx is index
    mov [bx], al    ; copying ascii char on al at [bx] addr
    ror dx, 4

    add cx, 1
    jmp hex_loop
end:
    mov bx, output_hex  ; parameter prep  
    call print
    popa
    ret
output_hex:
    db '0x0000', 0  ; reserved memory