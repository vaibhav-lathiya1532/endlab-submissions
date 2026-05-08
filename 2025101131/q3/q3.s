.data
    spa: .space 500
    cum_spa: .space 500
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
    li s2,0
    li s5,-1
extract_loop:
    bge s1,s0,next_func

    addi sp,sp,-16
    mv a1,sp
    la a0,fmt_intin
    call scanf
    lw t0,0(sp)
    addi sp,sp,16

    add s2,s2,t0
    la t1,spa
    slli t2,s1,2
    add t1,t1,t2
    sw t0,0(t1)

    la t1,cum_spa
    slli t2,s1,2
    add t1,t1,t2
    sw s2,0(t1)


    addi s1,s1,1
    j extract_loop
next_func:
    li s1,0
next_next_loop:
    bge s1,s0,pivot_notfound
    la t1,spa
    slli t2,s1,2
    add t1,t1,t2
    lw t0,0(t1)

    la t1,cum_spa
    slli t2,s1,2
    add t1,t1,t2
    lw t3,0(t1)
    sub t4,t3,t0
    sub t5,s2,t3
    beq t4,t5,pivot_found

    addi s1,s1,1
    j next_next_loop

pivot_found:
    mv s5,s1
    j ques_end
pivot_notfound:
    mv a1,s5
ques_end:
    mv a1,s5
    la a0,fmt_intout
    call printf

    ld ra, 8(sp)
    addi sp,sp,16
    li a0,0
    ret