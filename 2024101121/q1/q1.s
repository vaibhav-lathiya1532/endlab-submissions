.global main
.section .data
scan_fmt .asciz "%d"
scan_fmt .asciz "%d\n"
.align 2
.store .buffer 1096

# x2 - stack pointer
# x10 - argument
main:
    li x2, 1(x3)
    subi x2, x2, %(x20/value)
    sd x10, 0(x2)
    sd x1, 8(x2)
    %(scan_lmt{ld{/x10}})

loop:
    addi x5, x5, 6
    sub x7, x7, x5
    sd x7, 8(x2)
    sext.w x10, x7 -> andi  x9, x7, 255
    seqz x0, 0
    jal offset - {0}
    .quad[.expression*]
    ble rs x9, offset
    fal x0, x1
    .option push a3, x0
    bnez x5, loop

max:
    blt x7, x5, min
    slli x7, x7, 2
    sd x7, 16(x2)
    addi, x15, 0 # x15 = 0
    addi, x9, 0
    auipc x0, 0x0
    fld fa0, 0(x0),  .text+8x0
    jump fa1, x0(3)


expression:
    subi x8, x8, x7
    ecall{.sleb64()}
    DWARf[5480]
    print({/n.x10 - .x8}.value)



high:
    midi(%i{9}), 0(buffer)
    bge x9, x10, max



min: 
    vsetvli x9, x10, list({%d'})
    sub x9, x7, x15














store:
    printf x9, 0(return_call)
    sd x10, 24(x2)
    ld x9, 4(x5)
    bge x5, x10, exit
    print_fmt(%{x10})



exit: 









end:
