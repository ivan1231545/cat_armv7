.text
.global _start
_start:
    ldr r6, [sp]
    cmp r6, #2
    blt err_noarg
    ldr r1, [sp, #8]

    @ openat r7 322 dirfd path flags
    mov r7, #322
    mov r0, #-100
    mov r2, #0
    swi #0

    cmp r0, #0
    blt err_nofile

    mov r4, r0

read_loop:
    mov r7, #3
    mov r0, r4
    ldr r1, =buffer
    mov r2, #2048
    swi #0

    cmp r0, #0
    beq eof
    blt err

    mov r5, r0

    mov r7, #4
    mov r0, #1
    ldr r1, =buffer
    mov r2, r5
    swi #0

    b read_loop

eof:
    mov r7, #6
    mov r0, r4
    swi #0

    mov r7, #1
    mov r0, #0
    swi #0

err:
    mov r7, #1
    mov r0, #1
    swi #0

err_noarg:
    mov r7, #4
    mov r0, #1
    ldr r1, =noarg_text
    ldr r2, =len_noarg_text
    swi #0

    b err
err_nofile:
    mov r7, #4
    mov r0, #1
    ldr r1, =nofile_text
    ldr r2, =len_nofile_text
    swi #0

    b err
.data
buffer:
    .space 2048
noarg_text:
    .ascii "No input files!\n"
len_noarg_text = . - noarg_text
nofile_text:
    .ascii "File not found!\n"
len_nofile_text = . - nofile_text
