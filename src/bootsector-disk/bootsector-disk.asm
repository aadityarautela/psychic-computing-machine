[org 0x7c00]
    mov bp, 0x8000          ; init bp and sp
    mov sp, bp

    mov bx, 0x9000          ; from 0x0000(es) to 0x9000(bx) 
    mov dh, 2               ; load 2 sectors
    call load_disk

    mov dx, [0x9000]
    call print_hex
    call print_newline
    mov dx, [0x9000 + 512]
    call print_hex

    jmp $

%include "load-disk.asm"
%include "../bootsector-func-str/bootsector-print-hex.asm"
%include "../bootsector-func-str/bootsector-print-str.asm"


times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xfcfc
times 256 dw 0xdcdc
