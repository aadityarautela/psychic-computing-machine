; gdt
gdt_start:

gdt_null:   ; mandatory null descriptor
    dd 0x0  ; dd => dbl word => 4 bytes
    dd 0x0

gdt_code:           ; code segment descriptor
    ; base = 0x0, limit = 0xfffff
    ; first flags = 1(present) 00(privilege) 1(descriptor type) == 1001b
    ; type flags = 1(code) 0(conforming) 1(readable) 0(accessed) == 1010b
    ; second flags = 1(granularity) 1(32bit default) 0(64bit segment) 0(avl) == 1100b
    dw 0xffff       ; limit (bits 0-15)
    dw 0x0          ; base (bits 0-15)
    db 0x0          ; base (bits 16-23)
    db 10011010b    ; first flags, type flags
    db 11001111b    ; second flags, limit (bits 16-19)
    db 0x0          ; base (bits 24-31)

gdt_data:           ; data segment descriptor
    ; same as code except for type
    ; type flags = 0(code) 0(expand down) 1(writable) 0(accessed) == 1010b
    dw 0xffff       ; limit (bits 0-15)
    dw 0x0          ; base (bits 0-15)
    db 0x0          ; base (bits 16-23)
    db 10010010b    ; first flags, type flags
    db 11001111b    ; second flags, limit (bits 16-19)
    db 0x0          ; base (bits 24-31)

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; true size is one less than gdt size
    dd gdt_start

CODE_SEGMENT equ gdt_code - gdt_start
DATA_SEGMENT equ gdt_data - gdt_start