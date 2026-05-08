.data
    format_in:  .string "%lld"
    format_out: .string "%lld\n"
    num:    .dword 0

.text
.global main

main:
    addi sp, sp, -48
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)   # max
    sd s4, 40(sp)   # second max
    lla a0, format_in
    lla a1, num
    call scanf
    lla t0, num
    ld s0, 0(t0)    # s0 = n
    addi a0, s0, 0
    slli a0, a0, 3
    call malloc
    addi s1, a0, 0  # addr of array
    li s2, 0        # i = 0
    read:
        bge s2, s0, readend
        addi t0, s2, 0
        slli t0, t0, 3
        add a1, s1, t0
        lla a0, format_in
        call scanf
        addi s2, s2, 1
        j read

    readend:
        li s2, 0
    
    li s3, -10000000
    li s4, -10000000

    loop:
        bge s2, s0, end
        addi t0, s2, 0
        slli t0, t0, 3
        add t2, s1, t0
        ld t3, 0(t2)
        bge t3, s3, update_max
        bgt t3, s4, update_secondmax
        addi s2, s2, 1
        j loop
    
    update_max:
        beq s3, t3, except
        addi s4, s3, 0
        addi s3, t3, 0
        addi s2, s2, 1
        j loop

    except:
        addi s2, s2, 1
        j loop
    
    update_secondmax:
        addi s4, t3, 0
        addi s2, s2, 1
        j loop

    end:
        addi a1, s4, 0
        lla a0, format_out
        call printf
        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        ld s2, 24(sp)
        ld s3, 32(sp)   
        ld s4, 40(sp)
        addi a0, x0, 0   
        addi sp, sp, 48
        ret

