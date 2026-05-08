.section .data
input: .string "%lld"
output: .string "%lld"

.section .text
.global main

#s0=a, s1=b, s2=min, s3=gcd,s4=lcm
main:

    addi sp, sp, -56
    sd ra, 8(sp)
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)
    sd s3, 40(sp)
    sd s4, 48(sp)

    
    la a0, input
    addi a1, sp, 0
    call scanf

    ld s0, 0(sp)

    la a0, input
    addi a1, sp, 0
    call scanf

    ld s1, 0(sp)

    li s2, 0 #this is min

    find_min:
        blt s0, s1, min_a

        min_b:
            mv s2, s1
            j min_done

        min_a:
            mv s2, s0


    min_done:
        li t0, 1 #this is gcd
        li t1, 1 #i
        
        loop:
            bgt t1, s2, loop_done

            rem t2, s0, t1
            rem t3, s1, t1 

            bne t2, x0, not_div
            bne t3, x0, not_div
            
            div:
                mv t0, t1
                addi t1, t1, 1
                j loop

            not_div:
                addi t1,t1, 1
                j loop
            

        loop_done:      
            mv s3, t0 #s3=gcd

            li s4, 0 #lcm

            div t0, s0, s3
            div t1, s1, s3

            mul s4, t0, t1
            mul s4, s4, s3

            la a0, output
            mv a1, s3
            call printf

            li a0, 32
            call putchar

            la a0, output
            mv a1, s4
            call printf

            li a0, 10
            call putchar

            ld ra, 8(sp)
            ld s0, 16(sp)
            ld s1, 24(sp)
            ld s2, 32(sp)
            ld s3, 40(sp)
            ld s4, 48(sp)
            addi sp, sp, 56

            li a0, 0
            ret




