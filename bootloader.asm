; bootloader.asm
; Simple bootloader example
; Assemble with: nasm -f bin bootloader.asm -o bootloader.bin

BITS 16             ; 16-bit real mode code
ORG 0x7C00          ; BIOS loads bootloader at 0x7C00

start:
    ; Set up the stack
    cli                 ; Disable interrupts
    xor ax, ax
    mov ss, ax
    mov sp, 0x7C00      ; Set stack pointer near top of bootloader
    sti                 ; Enable interrupts

    ; Print message
    mov si, msg

print_loop:
    lodsb               ; Load byte at DS:SI into AL and increment SI
    cmp al, 0
    je done_printing

    mov ah, 0x0E        ; BIOS teletype output function
    int 0x10            ; Call BIOS video interrupt
    jmp print_loop

done_printing:
    ; Halt the CPU
hang:
    hlt
    jmp hang

msg db "Hello from Bootloader!", 0

; Boot signature (must be at offset 510 and 511)
times 510-($-$$) db 0
dw 0xAA55
