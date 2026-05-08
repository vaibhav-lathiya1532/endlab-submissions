.data
    fmt: .string "%s"
    s: .space 105
    fmt_out: .string "%lld\n"
.text

.globl main
main:
    addi sp,sp,-8
    sd ra,0(sp)

    la a0,fmt
    la a1,s
    call scanf
    la s0,s
    
    addi s1,x0,43 #plus
    addi s2,x0,45 #minus
    addi s3,x0,42 #mul

POST:
    lb t0,0(s0)
    beq t0,x0,PRINT

    IF:
        bne t0,s1,ELIF1
        ld t1,0(sp)
        addi sp,sp,8
        ld t2,0(sp)
        addi sp,sp,8
        add t3,t1,t2
        addi sp,sp,-8
        sd t3,0(sp)
        beq x0,x0,UPDATE

    ELIF1:
        bne t0,s2,ELIF2
        ld t1,0(sp)
        addi sp,sp,8
        ld t2,0(sp)
        addi sp,sp,8
        sub t3,t2,t1
        addi sp,sp,-8
        sd t3,0(sp)
        beq x0,x0,UPDATE

    ELIF2:
        bne t0,s3,ELSE
        ld t1,0(sp)
        addi sp,sp,8
        ld t2,0(sp)
        addi sp,sp,8
        mul t3,t1,t2
        addi sp,sp,-8
        sd t3,0(sp)
        beq x0,x0,UPDATE

    ELSE:
        addi sp,sp,-8
        addi t0,t0,-48
        sd t0,0(sp)

    UPDATE:
        addi s0,s0,1
        beq x0,x0,POST

PRINT:
    ld t0,0(sp)
    addi sp,sp,8
    la a0,fmt_out
    mv a1,t0
    call printf

    ld ra,0(sp)
    addi sp,sp,8
    ret


