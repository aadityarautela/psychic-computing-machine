; disk loading Subroutine
load_disk:
    push dx         ; save number of sectors requested even if altered
    mov ah, 0x02    ; bios read sector fn
    mov al, dh      ; read dh sectors
    mov ch, 0x00    ; read cylinder 0
    mov dh, 0x00    ; read head 0
    mov cl, 0x02    ; start reading from second sector (first is boot sector)
    int 0x13        ; interrupt for disk

    jc diskerr

    pop dx          ; popped the number of sectors requested
    cmp dh, al      ; check if requested = got
    jne diskerr
    ret

diskerr:
    mov bx, DISKERR_MSG
    call print
    jmp $

DISKERR_MSG db "DISK READ ERROR!!", 0

