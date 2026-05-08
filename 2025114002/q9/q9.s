.section .data
infmt: .string "%lld"
outfmt: .string "%lld\n"
N: .quad 0

.section .text
.global main

main:
    addi sp, sp, -48
    sd s1, 0(sp)
    sd s2, 8(sp)
    sd s3, 16(sp)
    sd s4, 24(sp)
    sd s5, 32(sp)
    sd ra, 40(sp)

    la a0, infmt
    la a1, N
    call scanf

    ld s1, N
    li s3, 100
    li s4, 10
    li s5, 1
   
    check:
        beq s1, s5, success

        beqz s3, fail
        addi s3, s3, -1

        li s2, 0
        reduceN:
            beqz s1, loadandloop

            rem t4, s1, s4
            mul t5, t4, t4
            add s2, s2, t5
            div s1, s1, s4

            j reduceN

        loadandloop:
        mv s1, s2
        j check

    fail:
        la a0, outfmt
        li a1, 0
        call printf
        j done
    
    success:
        la a0, outfmt
        li a1, 1
        call printf
        j done

    done:
    ld s1, 0(sp)
    ld s2, 8(sp)
    ld s3, 16(sp)
    ld s4, 24(sp)
    ld s5, 32(sp)
    ld ra, 40(sp)
    addi sp, sp, 48

li a0, 0
ret
