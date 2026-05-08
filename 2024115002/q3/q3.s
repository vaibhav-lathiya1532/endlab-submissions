.section .rodata

fmt_input: .string "%lld"


.section .text

.globl main

main:
    addi sp, sp, -48
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)

    addi s3, x0, 1

    lla a0, fmt_input
    addi a1, sp, 40
    call scanf

    ld s0, 40(sp) #N

    slli s1, s0, 3 #number of bytes

    addi a0, s1, 0

    call malloc
    addi s1, a0, 0 #pointer to array in memory

    
    addi s2, x0, 0 #counter

    read_loop:
    bge s2, s0, read_done
    slli t0, s2, 3
    add a1, t0, s1
    lla a0, fmt_input

    call scanf

    addi s2, s2, 1

    beq x0, x0, read_loop

    read_done:

        addi t0, x0, 0 #sum

        addi s2, x0, 0 #reset counter

        prime_loop_outer:
            bge s2, s0, done
            slli t1, s2, 3
            add t2, t1, s1

            ld t3, 0(t2) #arr[i]
            
            addi t4, x0, 0 #prime checker

            addi t5, x0, 1 #inner counter

            check_prime:
                bge t5, t3, continue_outer

            
                
                rem a0, t3, t5

                bne a0, x0, continue_prime_check
                
                addi t4, t4, 1


                continue_prime_check:

                addi t5, t5, 1
                beq x0, x0, check_prime


            
            continue_outer:
                addi t5, x0, 2

                bge t4, t5, go_to_outer
                beq t3, s3, go_to_outer
                    add t0, t0, t3


                go_to_outer:
                addi s2, s2, 1
                beq x0, x0, prime_loop_outer



    done:
        lla a0, fmt_input
        add a1, t0, x0
        call printf

    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)

    addi sp, sp, 48

    jalr x0, 0(ra)