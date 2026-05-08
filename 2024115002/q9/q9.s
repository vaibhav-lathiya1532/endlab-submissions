.section .rodata
fmt_input: .string "%lld"

.section .text

.globl main


main:
    addi sp, sp, -32
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)

    lla a0, fmt_input
    addi a1, sp, 24

    call scanf
    ld t0, 24(sp) #N

    addi t1, x0, 0 #iterations=0

    addi t2, x0, 100 

    addi t3, x0, 0 #answer
    addi s0, x0, 1
    addi s1, x0, 10

    loop:

    bge t1, t2, done

    beq s0, t0, done

    addi t5, x0, 0 #to sum square of digits
    
    inner_loop:
        beq x0, t0, continue_outer
        rem t4, t0, s1
        mul t4, t4, t4
        add t5, t5, t4
        div t0, t0, s1
        beq x0, x0, inner_loop

    continue_outer:
        add t0, x0, t5
        addi t1, t1, 1
        beq x0, x0, loop


    done:
        bne t0, s0, not_happy
        lla a0, fmt_input
        addi a1, x0, 1
        call printf
        beq x0, x0, common_exit

        not_happy:
        lla a0, fmt_input
        addi a1, x0, 0
        call printf


common_exit:
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)

    addi sp, sp, 32

    jalr x0, 0(ra)



    