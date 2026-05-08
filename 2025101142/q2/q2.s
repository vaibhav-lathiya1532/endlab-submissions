.section .rodata
    fmt: .asciz "%ld %ld"
    fmt_out: .asciz "%ld %ld\n"

.section .text
.global main

main:
    addi sp,sp,-64
    sd ra,0(sp)

    # 8(sp) ---> a
    # 16(sp)---> b
    # 24(sp)---> gcd
    # 32(sp)---> lcm
    # 40(sp)---> i
    # 48(sp)---> min(a,b)
    # 56(sp)---> a*b

    la a0,fmt
    addi a1,sp,8
    addi a2,sp,16
    call scanf

    li t0,1
    sd t0,40(sp)

    ld t1,8(sp)
    ld t2,16(sp)
    ble t1,t2,min_a

    sd t2,48(sp)
    mul t1,t1,t2
    sd t1,56(sp)

    j gcd_loop

min_a:
    ld t1,8(sp)
    ld t2,16(sp)

    sd t1,48(sp)
    mul t1,t1,t2
    sd t1,56(sp)

    j gcd_loop

gcd_loop:
    ld t0,40(sp)    # i
    ld t1,48(sp)    # n

    bgt t0,t1,lcm

    ld t2,8(sp)
    ld t3,16(sp)

    rem t4,t2,t0
    bnez t4,next_gcd
    rem t5,t3,t0
    bnez t5,next_gcd

    ld t0,40(sp)    
    sd t0,24(sp)

    addi t0,t0,1
    sd t0,40(sp)

    j gcd_loop

next_gcd:
    ld t0,40(sp)    # i
    addi t0,t0,1
    sd t0,40(sp)

    j gcd_loop

lcm:
    ld t0,48(sp)    # min
    sd t0,40(sp)    # i = min

lcm_loop:
    ld t0,56(sp)    # max = a*b
    ld t1,40(sp)    # i

    bgt t1,t0,end

    ld t2,8(sp)
    ld t3,16(sp)

    rem t4,t1,t2
    bnez t4,next_lcm
    rem t5,t1,t3
    bnez t5,next_lcm

    ld t1,40(sp)
    sd t1,32(sp)

    j end

next_lcm:
    ld t1,40(sp)
    addi t1,t1,1
    sd t1,40(sp)

    j lcm_loop

end:
    la a0,fmt_out
    ld a1,24(sp)
    ld a2,32(sp)
    call printf

    ld ra,0(sp)
    addi sp,sp,64
    li a0,0
    ret
