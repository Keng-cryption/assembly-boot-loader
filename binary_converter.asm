section .data
    input resd 8
    result dd 0
    format db "%d", 0

section .bss
    i resd 1

section .text
    extern scanf, printf, pow
    global main

main:
    ; Read input
    mov dword [i], 0
read_loop:
    cmp dword [i], 8
    jge end_read_loop
    lea rdi, [input + rdi*4]
    lea rsi, [format]
    call scanf
    inc dword [i]
    jmp read_loop
end_read_loop:

    ; Calculate result
    mov dword [result], 0
    mov dword [i], 0
calc_loop:
    cmp dword [i], 8
    jge end_calc_loop
    mov eax, [input + rdi*4]
    cmp eax, 1
    jne skip_add
    mov eax, 2
    mov ecx, [i]
    call pow
    add dword [result], eax
skip_add:
    inc dword [i]
    jmp calc_loop
end_calc_loop:

    ; Print result
    mov eax, [result]
    lea rdi, [format]
    call printf

    ; Return
    mov eax, 0
    ret
