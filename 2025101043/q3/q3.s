.data
n: .word 0
iformat: .string "%d"
oformat: .string "%d"

.text
.global main

main:

    addi sp,sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    # ----------- store the saved registers here-----------------

    la a0, iformat
    la a1, n
    call scanf

    la t0, n
    lw s0, 0(t0)

    #la a0, oformat
    #mv a1, s0
    #call printf

    # -------------- variables ----------------
    # s0 -> n
    # s2-> sum
    # s3-> input number

setup_input_loop:

    mv s2,x0

input_loop:

    beq s0,x0,end_input_loop

    la a0,iformat
    la a1,n
    call scanf

    addi s0,s0,-1

    la t0,n
    lw s3,0(t0)

    li t0, 1
    setup_check_prime:
        
        beq t0,s3,not_prime

        li t0,2

    check_prime_loop:

        mul t1,t0,t0

        bgt t1,s3,prime

        rem t2,s3,t0

        beq t2,x0, not_prime

        addi t0,t0,1
        j check_prime_loop

    prime:

        add s2,s2,s3
        j input_loop

    not_prime:

        j input_loop


end_input_loop:

    la a0, oformat
    mv a1, s2
    call printf

end:

    ld ra,0(sp)
    ld s0,8(sp)
    ld s1,16(sp)
    ld s2,24(sp)
    ld s3,32(sp)
    addi sp,sp,64

    mv a0,x0
    call exit
