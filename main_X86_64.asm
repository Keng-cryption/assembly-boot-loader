; Simple bootloader with menu
; Assemble with: nasm -f bin bootloader.asm -o bootloader.bin
; Run in QEMU: qemu-system-x86_64 -drive format=raw,file=bootloader.bin

BITS 16
ORG 0x7C00

start:
    cli                 ; Disable interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00      ; Set stack pointer

    call clear_screen
    call print_menu

wait_key:
    mov ah, 0           ; BIOS keyboard int to read key
    int 0x16
    cmp al, '1'
    je boot_os_a
    cmp al, '2'
    je boot_os_b
    jmp wait_key        ; wait for valid key

boot_os_a:
    call clear_screen
    mov si, msg_os_a
    call print_string
    jmp halt

boot_os_b:
    call clear_screen
    mov si, msg_os_b
    call print_string
    jmp halt

; ---------------------
; Print the menu text
print_menu:
    mov si, menu_text
.print_loop:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0E        ; BIOS teletype print
    mov bh, 0
    mov bl, 7
    int 0x10
    jmp .print_loop
.done:
    ret

; ---------------------
; Clear screen by scrolling 0 lines up
clear_screen:
    mov ah, 0x06
    mov al, 0
    mov bh, 7
    mov cx, 0
    mov dx, 0x184F       ; bottom-right corner (row=24,col=79)
    int 0x10
    ret

; ---------------------
; Print zero-terminated string at DS:SI
print_string:
    mov ah, 0x0E
.print_char:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .print_char
.done:
    ret

halt:
    cli
    hlt
    jmp halt

; ---------------------
menu_text db "Select OS to boot:", 0x0D, 0x0A
           db "1) Boot OS A", 0x0D, 0x0A
           db "2) Boot OS B", 0x0D, 0x0A, 0

msg_os_a db "Booting OS A...", 0x0D, 0x0A, 0
msg_os_b db "Booting OS B...", 0x0D, 0x0A, 0

; Boot signature (must be at 510-511)
times 510 - ($ - $$) db 0
dw 0xAA55

