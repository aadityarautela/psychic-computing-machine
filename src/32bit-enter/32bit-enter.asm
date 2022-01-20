; boot sector which enters 32bit pm
[org 0x7c00]
    mov bp, 0x9000  ; init stack
    mov sp, bp

    mov bx, MSG_RM  
    call print

    call switch_to_pm   ; non returning

    jmp $

%include "../bootsector-func-str/bootsector-print-str.asm"
%include "../32bit-gdt/32bit-gdt.asm"
%include "../32bit-print/32bit-print.asm"
%include "32bit-switch.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PM
    call print_string_pm    ; 32bit print
    
    jmp $

; Global Var
MSG_RM db "Started in 16bit real mode",0
MSG_PM db "Started in 32bit protected mode",0

times 510-($-$$) db 0
dw 0xaa55