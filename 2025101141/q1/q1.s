.data
input: .asciz "%lld"
true: .asciz "TRUE\n"
false: .asciz "FALSE\n"

.text
.globl main

# 0(sp) = ra
# 8(sp) = n
# 16(sp) = arr base addr

main:
    addi sp, sp, -32
    sd ra, 0(sp)

    la a0, input
    add a1, sp, 8
    call scanf

    ld a0, 8(sp)
    slli a0, a0, 2
    call malloc
    ld a0, 16(sp)

    li s1, 0    # i
    ld s2, 8(sp)    # n
    ld s3, 16(sp)   # arr base addr
    for_scanning:
        bge s1, s2, done_scanning

        la a0, input
        mv a1, s1
        slli a1, a1, 2
        add a1, a1, s3
        call scanf

        addi s1, s1, 1
        j for_scanning
    
    done_scanning:
        ld s1, 16(sp)
        ld s1, 0(s1)
        li t0, 2

    rem s1, s1, t0  # cur
    li s2, 1    # i
    ld s3, 8(sp)    # n
    ld s4, 16(sp)   # arr base addr
    for:
        bge s2, s3, done

        mv t0, s2
        slli t0, t0, 2
        add t0, t0, s4
        ld t0, 0(t0)    # t0 = arr[i]
        li t1, 2
        rem t0, t0, t1

        beq t0, s1, print_false

        mv s1, t0
        addi s2, s2, 1
        j for
    
    print_false:
        la a0, false
        call printf
        j exit
    
    done:
        la a0, true
        call printf
        j exit

    exit:
        ld ra, 0(sp)
        li a0, 0
        addi sp, sp, 32
        ret
        