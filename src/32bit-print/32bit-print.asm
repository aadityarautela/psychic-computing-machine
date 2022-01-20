[bits 32]
; video memory constants
VIDEO_MEMORY equ 0xb8000
W_ON_B equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY   ; set edx to start of vmem

print_string_pm_loop:
    mov al, [ebx]   ; char at ebx stored at al
    mov ah, W_ON_B  ; attributes on ah

    cmp al, 0       ; if al==0 jump to done
    je print_string_pm_done

    mov [edx], ax   ; char + attr stored in current char cell
    add ebx, 1  ; increment ebx to next char
    add edx, 2  ; increment edx to next char cell in vmem

    jmp print_string_pm_loop    ; print next char

print_string_pm_done:
    popa
    ret