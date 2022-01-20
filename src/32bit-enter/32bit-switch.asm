[bits 16]
switch_to_pm:
    cli                     ; switching off all interrupts until pm interrupt vector is setup
                            ; else interrupts will run riot
    
    lgdt [gdt_descriptor]   ; loading gdt
    
    mov eax, cr0            ; setting first bit of cr0 (control register)
    or eax, 0x1             ; to make switch to pm
    mov cr0, eax
    
    jmp CODE_SEGMENT:init_pm    ; jmp to far location to 32 bit code
                                ; to flush pending cpu operations
                                ; assuming parallelism 

[bits 32]
; init registers and the stack once switched to pm
init_pm:
    mov ax, DATA_SEGMENT    ; in pm, old segments are meaningless
    mov ds, ax              ; so pointing segment registers to data segment 
    mov ss, ax              ; defined in gdt
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; update stack pos to make it top of the free space
    mov esp, ebp

    call BEGIN_PM           ; calling known label