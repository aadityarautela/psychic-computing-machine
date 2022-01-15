; Infinite Loop
loop:
    jmp loop

; Writing (510 - above code size) number of zeroes
times 510-($-$$) db 0
; Bootable Magic Number
dw 0xaa55