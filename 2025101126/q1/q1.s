.data
inputfmt: .string "%lld"
testfmt: .string "%lld\n"
outputfmt: .string "TRUE\n"
outputfmt_no: .string "FALSE\n"
.text
.globl main
.extern scanf
.extern printf
main:   
    addi sp, sp, -40
    sd ra, 0(sp)
    sd s0, 8(sp)    #n
    sd s1, 16(sp)   #valid bit
    sd s2, 24(sp)   #count
    sd s3, 32(sp)   #number

    la a0, inputfmt
    addi a1, sp, 8
    call scanf
    ld s0, 8(sp)
    addi s2, x0, 0
    addi s1, x0, 0
first_input:
    la a0, inputfmt
    addi a1, sp, 32
    call scanf
    ld s3, 32(sp)

    addi t0, x0, 2
    rem t1, s3, t0
    addi s1, t1, 0
    addi s2, s2, 1
loop:
    beq s2, s0, yes
    la a0, inputfmt
    addi a1, sp, 32
    call scanf
    ld s3, 32(sp)

    addi t0, x0, 2
    rem t1, s3, t0

    beq t1, s1, not_true
    addi s1, t1, 0
    addi s2, s2, 1
    j loop
yes:
    la a0, outputfmt
    call printf
    ld ra, 0(sp)
    ld s0, 8(sp)    #n
    ld s1, 16(sp)   #valid bit
    ld s2, 24(sp)   #count
    ld s3, 32(sp)   #number
    addi sp, sp, 40
    ret
not_true:
    la a0, outputfmt_no
    call printf
    ld ra, 0(sp)
    ld s0, 8(sp)    #n
    ld s1, 16(sp)   #valid bit
    ld s2, 24(sp)   #count
    ld s3, 32(sp)   #number
    addi sp, sp, 40
    ret
