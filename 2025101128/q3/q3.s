.data
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"

.text
.global main

main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)
    sd s1,40(sp)
    sd s2,32(sp)
    sd s3,24(sp)
    sd s4,16(sp)
    sd s5,8(sp)

    addi a1,sp,0
    la a0,fmt_in
    call scanf

    ld s0,0(sp)
    slli a0,s0,3
    call malloc

    mv s1,a0

    slli a0,s0,3
    call malloc

    mv s2,a0

    slli a0,s0,3
    call malloc

    mv s3,a0

    li s4,0
    li s5,0

    input_loop:
        beq s4,s0,input_done

        la a0,fmt_in
        slli a1,s4,3
        add a1,a1,s1
        call scanf

        #update prefarr
        slli a1,s4,3
        add a1,a1,s2
        sd s5,0(a1)

        sub a1,a1,s2
        add a1,a1,s1
        ld t0,0(a1)
        add s5,s5,t0

        addi s4,s4,1
        j input_loop

    input_done:
        li s5,0
        mv s4,s0
        addi s4,s4,-1
        
    suff_loop:
        blt s4,x0,compare
        
        slli t0,s4,3
        add t0,t0,s3
        sd s5,0(t0)

        slli t0,s4,3
        add t0,t0,s1
        ld t0,0(t0)

        add s5,s5,t0
        addi s4,s4,-1
        j suff_loop

    compare:
        li s4,0
        j compare_loop

    compare_loop:
        beq s4,s0,not_found

        slli t1,s4,3
        slli t2,s4,3
        add t1,t1,s2
        add t2,t2,s3
        ld t1,0(t1)
        ld t2,0(t2)

        beq t1,t2,found

        addi s4,s4,1
        j compare_loop

    found:
        mv a1,s4
        la a0,fmt_out
        call printf
        j end

    not_found:
        li a1,-1
        la a0,fmt_out
        call printf
        j end

    end:
        ld ra,56(sp)
        ld s0,48(sp)
        ld s1,40(sp)
        ld s2,32(sp)
        ld s3,24(sp)
        ld s4,16(sp)
        ld s5,8(sp)
        addi sp,sp,64

        li a0,0

        ret


