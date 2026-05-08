.data

    fmt_in: .string "%lld"
    fmt_out: .string "%lld %lld"
    input: .dword 0


.text
.globl main

main: 

    addi sp, sp, -16
    sd ra, 0(sp)

    la a0, fmt_in
    la a1, input
    call scanf
    la s0, input
    ld s0, 0(s0)                #s0 = a 

    la a0, fmt_in
    la a1, input
    call scanf
    la s1, input
    ld s1, 0(s1)                #s1 = b 

    mv s2, s1               
    mv s3, s0

    gcd: 

        beqz s3, gcd_found

        mv t0, s3
        rem s3, s2, s3
        mv s2, t0

        j gcd
        
    gcd_found:

    #gcd is stored in s2 now


    lcm:

        mul s9, s0, s1                              #s9= a*b 

        mv s5, s0
        mv s6, s1                                       #s5  and s6 are copies of and b to be multiplied

        li s7, 2                                #mul index for a 
        li s8, 2                                #mul index for b

        while_loop:

            bge s5, s9, done 
            bge s6, s9, done     

            bge s5, s6, a_bigger

            b_bigger: 

            mul s5, s0, s7
            addi s7, s7, 1  
            beq s5, s6, lcm_found
            j while_loop

            a_bigger: 

            mul s6, s1, s8
            addi s8, s8, 1
            beq s5, s6, lcm_found
            j while_loop

        lcm_found:

            la a0, fmt_out
            mv a1, s2
            mv a2, s5 
            call printf 
            j exit 

        done :
            la a0, fmt_out
            mv a1, s2
            mv a2, s9
            call printf
            j exit

        exit: 

            ld ra, 0(sp)
            addi sp, sp, 16
            li a0, 0
            ret 












