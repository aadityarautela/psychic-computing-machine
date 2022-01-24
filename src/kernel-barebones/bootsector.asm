[org 0x7c00]
KERNEL_OFFSET equ 0x1000    ; mem offset to which kernel is loaded
    mov [BOOT_DRIVE], dl    ; save bootdrive
    mov bp, 0x9000          ; setup stack
    mov sp, bp
    mov bx, MSG_RM   
    call print
    call load_kernel        ; load kernel
    call switch_to_pm       ; switch to 32bit
    jmp $

%include "../bootsector-func-str/bootsector-print-str.asm"
%include "../bootsector-disk/load-disk.asm"
%include "../32bit-gdt/32bit-gdt.asm"
%include "../32bit-enter/32bit-switch.asm"
%include "../32bit-print/32bit-print.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL     ; kernel loading message
    call print
    call print_newline

    mov bx, KERNEL_OFFSET       ; read disk, store in KERNEL_OFFSET
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call load_disk
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PM
    call print_string_pm
    call KERNEL_OFFSET  ; give control to kernel
    jmp $               ; loop here if kernel returns control

BOOT_DRIVE db 0
MSG_RM db "16bit mode",0
MSG_PM db "32bit mode",0
MSG_LOAD_KERNEL db "Loading kernel into memory",0

times 510 - ($-$$) db 0
dw 0xaa55
