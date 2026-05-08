.data
    fmt_in: .string "%lld"
    fmt_true: .string "TRUE\n"
    fmt_false: .string "FALSE\n"


.text
.global main

main:
    addi sp,sp, -48
    sd ra, 40(sp)
    sd s0,32(sp)
    sd s1,24(sp)
    sd s2,16(sp)
    sd s3,8(sp)


    la a0,fmt_in
    addi a1,sp,0
    call scanf
    ld s0, 0(sp)

    mv t0,s0
    li s1,0

count_loop:
    beq t0, zero, count_done
    li t1,10
    div t0,t0,t1
    addi s1,s1,1
    j count_loop

count_done:
    li s2,0
    mv t6,a0
    addi t3,s1,0
    li t2,1
build_loop:
    beq t3,t2,exit
    li t1,10
    addi t4, t6,0
    rem t6,t6,t1
    li t5,1
    jal pow_loop
    
pow_loop:
    beq t5,t3,build_loop
    add s,s,t6
    addi t5,t5,1

