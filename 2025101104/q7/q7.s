.data
    format_in:  .string "%lld"
    format_out: .string "%s\n"
    true:   .string "TRUE"
    false:  .string "FALSE"
    num:    .dword 0

.text
.global main

main:
    addi sp, sp, -48
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    lla a0, format_in
    lla a1, num
    call scanf
    lla t0, num
    ld s0, 0(t0)    # s0 = n
    addi t0, s0, 0  # copy of number
    li s2, 0        # number of digits
    li t1, 10
    digit_loop:
        beqz t0, loop_end
        rem t2, t0, t1
        div t0, t0, t1
        addi s2, s2, 1
        j digit_loop
    loop_end:
        li s3, 0        # total sum = 0
        addi t0, s0, 0  # copy of n

    loop2:
        beqz t0, loop2_end
        rem t2, t0, t1
        div t0, t0, t1
        li t3, 1
        li t4, 0
        power_loop:
            bge t4, s2, power_end
            mul t3, t3, t2
            addi t4, t4, 1
            j power_loop
        power_end:
            addi s2, s2, -1
            add s3, s3, t3
            j loop2
    
    loop2_end:
        beq s0, s3, yes
        lla a0, format_out
        lla a1, false
        call printf
        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        ld s2, 24(sp)
        ld s3, 32(sp)   
        ld s4, 40(sp)
        addi sp, sp, 48
        addi a0, x0, 0
        ret

    yes:
        lla a0, format_out
        lla a1, true
        call printf
        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        ld s2, 24(sp)
        ld s3, 32(sp)   
        ld s4, 40(sp)
        addi sp, sp, 48
        addi a0, x0, 0
        ret
        