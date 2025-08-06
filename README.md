# Simple Bootloader Examples: x86 and ARM64

This repository contains two minimal bootloader examples:

1. **x86 Bootloader** (16-bit real mode) — displays a simple menu on boot  
2. **ARM64 Bootloader** (using semihosting) — prints a message in an ARM emulator  

---

## Contents

- `bootloader.asm` — x86 assembly bootloader (NASM syntax)  
- `bootloader.S` — ARM64 assembly bootloader (GNU assembler syntax)  

---

## x86 Bootloader

### Description

- A 512-byte MBR bootloader for x86 PCs.  
- Runs in 16-bit real mode after BIOS loads it at `0x7C00`.  
- Displays a text menu allowing the user to press `1` or `2` to choose an OS.  
- Prints a confirmation message of the chosen OS and then halts.

### Build

You need NASM (Netwide Assembler) to assemble the code:

```bash
nasm -f bin bootloader.asm -o bootloader.bin
