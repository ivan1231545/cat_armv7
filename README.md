# cat_armv7

ARMv7 assembly implementation of the Unix `cat` utility.

This project demonstrates low-level Linux system calls on 32-bit ARM (ARMv7-A) architecture without using any C runtime or standard library. The program reads a file specified as a command-line argument and prints its contents to stdout.

## Features

- Pure ARMv7 assembly (GNU as syntax).
- Uses Linux system calls directly (`openat`, `read`, `write`, `close`, `exit`).
- Handles basic error cases:
  - No input arguments → prints `No input files!`
  - File not found → prints `File not found!`
- Static binary, no external dependencies.

## Requirements

- A Linux environment with ARMv7 support (real hardware, QEMU, or Termux on Android).
- GNU Assembler (`as`) and linker (`ld`) for ARM, or `clang`/`gcc` with ARM cross-compilation support.

## Build

### Option 1: Using clang (recommended for simplicity)

```bash
clang --target=armv7a-linux-gnueabihf -nostdlib -static -o cat_armv7 cat_armv7.s
```

### Option 2: Using GNU Toolchain

```bash
arm-linux-gnueabihf-as -o cat_armv7.o cat_armv7.s
arm-linux-gnueabihf-ld -o cat_armv7 cat_armv7.o```
```

### Usage
```bash
./cat_armv7 somefile.txt
```

Ensure the binary is executed on an ARMv7-compatible system. On x86_64 hosts, you can use QEMU:

```bash
qemu-arm -L /usr/arm-linux-gnueabihf ./cat_armv7 somefile.txt
```
###How It Works

The program performs the following steps:

Checks that at least one command-line argument is provided.
Retrieves the filename from argv.
Opens the file using the openat syscall (syscall number 322 on ARM EABI).
Reads the file in 2048-byte chunks using read (syscall 3).
Writes each chunk to stdout using write (syscall 4).
Closes the file and exits with status 0 on success, or 1 on error.

### License

This project is licensed under the MIT License — see the  file for details.
