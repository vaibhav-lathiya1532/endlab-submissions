.data
inputfmt: .string "%lld"
outputfmt: .string "%lld "
outputfmt_end: .string "%lld\n"
.text
.globl main
.extern scanf
.extern printf
main:
    addi sp, sp, -72
    sd ra, 0(sp)
    sd s0, 8(sp)    #actual price
    sd s1, 16(sp)   #price paid
    sd s2, 24(sp)   #change to be paid
    sd s3, 32(sp)   #ans-1
    sd s4, 40(sp)   #ans-2
    sd s5, 48(sp)   #ans-3
    sd s6, 56(sp)   #ans-4
    sd s7, 64(sp)   #change counter
    
    la a0, inputfmt
    addi a1, sp, 8
    call scanf
    ld s0, 8(sp)

    la a0, inputfmt
    addi a1, sp, 16
    call scanf
    ld s1, 16(sp)

    sub s2, s1, s0
    addi s3, x0, 0
    addi s4, x0, 0
    addi s5, x0, 0
    addi s6, x0, 0
    addi s7, x0, 25
loop:
    blt s2, s7, loop_ctrl
    sub s2, s2, s7
    addi s3, s3, 1
    j loop
loop_ctrl:
    addi s7, s7, -15
loop1:
    blt s2, s7, loop_ctrl1
    sub s2, s2, s7
    addi s4, s4, 1
    j loop1
loop_ctrl1:
    addi s7, s7, -5
loop2:
    blt s2, s7, loop3
    sub s2, s2, s7
    addi s5, s5, 1
    j loop2
loop3:
    addi s6, s2, 0
main2:
    la a0, outputfmt
    addi a1, s3, 0
    call printf
    la a0, outputfmt
    addi a1, s4, 0
    call printf
    la a0, outputfmt
    addi a1, s5, 0
    call printf
    la a0, outputfmt_end
    addi a1, s6, 0
    call printf
    ld ra, 0(sp)
    ld s0, 8(sp)    #actual price
    ld s1, 16(sp)   #price paid
    ld s2, 24(sp)   #change to be paid
    ld s3, 32(sp)   #ans-1
    ld s4, 40(sp)   #ans-2
    ld s5, 48(sp)   #ans-3
    ld s6, 56(sp)   #ans-4
    ld s7, 64(sp)   #change counter
    addi sp, sp, 72
    ret
