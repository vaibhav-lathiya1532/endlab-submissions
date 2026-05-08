.data
    fmt_intin: .string "%d"
    fmt_intout: .string "%d\n"
.text
.globl main
main:
    addi sp,sp,-16
    sd ra, 8(sp)

    addi sp,sp,-16
    mv a1,sp
    la a0,fmt_intin
    call scanf
    lw s0,0(sp)
    addi sp,sp,16
    li s1,0
    li t2,10
happy_loop:
    li s3,0
    mv t1,s0
    li t0,100
    bge s1,t0,not_happy
sum_loop:
    li t4,0
    beq t1,t4,dig_done
sing_dig:
    rem t3,t1,t2
    div t1,t1,t2
    mul t3,t3,t3
    add s3,s3,t3
    j sum_loop
dig_done:
    li t5,1
    beq t5,s3,happy
    mv s0,s3
    addi s1,s1,1
    j happy_loop
happy:
    li a1,1
    la a0,fmt_intout
    call printf
    j ques_end
not_happy:
    li a1,0
    la a0,fmt_intout
    call printf
ques_end:
    ld ra, 8(sp)
    addi sp,sp,16
    li a0,0
    ret