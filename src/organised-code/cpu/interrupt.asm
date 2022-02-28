; defined in isr.c
[extern isr_handler]

; Common Code
isr_common_stub:
    ; saving cpu state
    pusha ; pushes edi, esi, ebp, esp, eax, ebx, ecx, edx
    mov ax, ds ; lower 16bits of eax = ds
    push eax ; save data segment descriptor
    mov ax, 0x10 ; kernel data segment descriptor
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; calling C handler
    call isr_handler

    ; restore state
    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    add esp, 8 ; cleans pushed err code and pushed isr number
    sti
    iret ; pops cs, eip, eflags, ss and esp

; Different interrupt handlers are required for different interrupts
; Some interrupts push an error code to the stack, others don't
; To maintain consistent stack, dummy error code is pushed for which
; error code isn't pushed 

; making ISRs global
global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; 0: Division By Zero
isr0:
    cli
    push byte 0
    push byte 0
    jmp isr_common_stub

; 1: Single-step interrupt (Debug)
isr1:
    cli
    push byte 0
    push byte 1
    jmp isr_common_stub

; 2: Non Maskable Interrupt 
isr2:
    cli
    push byte 0
    push byte 2
    jmp isr_common_stub

; 3: Breakpoint
isr3:
    cli
    push byte 0
    push byte 3
    jmp isr_common_stub

; 4: Overflow
isr4:
    cli
    push byte 0
    push byte 4
    jmp isr_common_stub

; 5: Bound Range Exceeded
isr5:
    cli
    push byte 0
    push byte 5
    jmp isr_common_stub

; 6: Invalid Opcode
isr6:
    cli
    push byte 0
    push byte 6
    jmp isr_common_stub

; 7: Coprocessor not available
isr7:
    cli
    push byte 0
    push byte 7
    jmp isr_common_stub

; 8: Double Fault (WITH ERROR CODE)
isr8:
    cli
    push byte 8
    jmp isr_common_stub

; 9: Coprocessor Segment Overrun
isr9:
    cli
    push byte 0
    push byte 9
    jmp isr_common_stub

; 10: Invalid Task State Segment (WITH ERROR CODE)
isr10:
    cli
    push byte 10
    jmp isr_common_stub

; 11: Segment Not Present (WITH ERROR CODE)
isr11:
    cli
    push byte 11
    jmp isr_common_stub

; 12: Stack Segment Fault (WITH ERROR CODE)
isr12:
    cli
    push byte 12
    jmp isr_common_stub

; 13: General Protection Fault (WITH ERROR CODE)
isr13:
    cli
    push byte 13
    jmp isr_common_stub

; 14: Page Fault (WITH ERROR CODE)
isr14:
    cli
    push byte 14
    jmp isr_common_stub

; 15: Unknown (Reserved)
isr15:
    cli
    push byte 0
    push byte 15
    jmp isr_common_stub

; 16: x87 Floating Point Exception (Coprocessor Fault)
isr16:
    cli
    push byte 0
    push byte 16
    jmp isr_common_stub

; 17: Alignment Check 
isr17:
    cli
    push byte 0
    push byte 17
    jmp isr_common_stub

; 18: Machine Check
isr18:
    cli
    push byte 0
    push byte 18
    jmp isr_common_stub

; 19: Reserved
isr19:
    cli
    push byte 0
    push byte 19
    jmp isr_common_stub

; 20: Reserved
isr20:
    cli
    push byte 0
    push byte 20
    jmp isr_common_stub

; 21: Reserved
isr21:
    cli
    push byte 0
    push byte 21
    jmp isr_common_stub

; 22: Reserved
isr22:
    cli
    push byte 0
    push byte 22
    jmp isr_common_stub

; 23: Reserved
isr23:
    cli
    push byte 0
    push byte 23
    jmp isr_common_stub

; 24: Reserved
isr24:
    cli
    push byte 0
    push byte 24
    jmp isr_common_stub

; 25: Reserved
isr25:
    cli
    push byte 0
    push byte 25
    jmp isr_common_stub

; 26: Reserved
isr26:
    cli
    push byte 0
    push byte 26
    jmp isr_common_stub

; 27: Reserved
isr27:
    cli
    push byte 0
    push byte 27
    jmp isr_common_stub

; 28: Reserved
isr28:
    cli
    push byte 0
    push byte 28
    jmp isr_common_stub

; 29: Reserved
isr29:
    cli
    push byte 0
    push byte 29
    jmp isr_common_stub

; 30: Reserved
isr30:
    cli
    push byte 0
    push byte 30
    jmp isr_common_stub

; 31: Reserved
isr31:
    cli
    push byte 0
    push byte 31
    jmp isr_common_stub