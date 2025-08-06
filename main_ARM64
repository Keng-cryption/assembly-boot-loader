    .section .text
    .global _start

_start:
    // Prepare parameters for semihosting SYS_WRITE0
    ldr x0, =msg      // pointer to string
    mov x1, #0       // unused for SYS_WRITE0

    mov x16, #4      // SYS_WRITE0 syscall number
    svc #0           // make semihosting call

    // Exit cleanly
    mov x0, #0
    mov x16, #0x18   // SYS_EXIT syscall number
    svc #0

.section .rodata
msg:
    .asciz "Hello from ARM64 bootloader!\n"
