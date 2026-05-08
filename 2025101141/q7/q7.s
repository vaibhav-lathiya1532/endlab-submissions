.data
input: .asciz "%s"
true: .asciz "TRUE\n"
false: .asciz "FALSE\n"

.text
.globl main

# 0(sp) = ra
# 8(sp) = number arr staring addr
# 16(sp) = n

main:
    addi sp, sp, -32
    sd ra, 0(sp)

    li a0, 11
    call malloc
    sd a0, 8(sp)

    la a0, input
    ld a1, 8(sp)
    call scanf

    ld a0, 8(sp)
    call strlen
    sd a0, 16(sp)

    li s2, 0    # sum
    li s3, 0    # i
    ld s4, 16(sp)   # n
    ld s5, 8(sp)    # number arr staring addr
    for:
        bge s3, s4, done

        add s6, s5, s3
        lb s6, 0(s6)
        addi s6, s6, -'0'   # s6 = digit
        addi s7, s3, 1      # s7 = power
        li s8, 1            # s8 = toAdd

        li s1, 0    # j
        for_inner:
            bge s1, s7, done_inner
            mul s8, s8, s6
            addi s1, s1, 1
            j for_inner
        
        done_inner:
            add s2, s2, s8
            addi s3, s3, 1
            j for
    
    done:
        ld a0, 8(sp)
        call atoi

        beq a0, s2, print_true
        la a0, false
        call printf
        j exit

        print_true:
            la a0, true
            call printf
            j exit
    
    exit:
        ld ra, 0(sp)
        addi sp, sp, 32
        li a0, 0
        ret
