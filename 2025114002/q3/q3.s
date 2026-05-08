.section .data
infmt: .string "%lld"
outfmt: .string "%lld\n"
N: .quad 0
arr: .space 840

.section .text
.global main

main:
    addi sp, sp, -48
    sd s1, 0(sp)
    sd s2, 8(sp)
    sd s3, 16(sp)
    sd s4, 24(sp)
    sd ra, 32(sp)

    la a0, infmt
    la a1, N
    call scanf

    ld s1, N

    li s2, 0
    readarray:
        beq s2, s1, readdone

        la t0, arr
        slli t1, s2, 3
        add t2, t1, t0

        la a0, infmt
        mv a1, t2
        call scanf

        addi s2, s2, 1
        j readarray
    
    readdone:
    li s2, 0                    # i

    getbothsums:
        beq s2, s1, nopivot

        li s3, 0                    # lsum
        li s4, 0                    # rsum
        li t3, 0
        getleftsum:
            beq t3, s2, leftsumhere

            la t0, arr
            slli t1, t3, 3
            add t2, t1, t0

            ld t5, 0(t2)
            add s3, s3, t5

            addi t3, t3, 1
            j getleftsum

        leftsumhere:
        addi t4, s2, 1
        getrightsum:
            beq t4, s1, rightsumhere

            la t0, arr
            slli t1, t4, 3
            add t2, t1, t0

            ld t6, 0(t2)
            add s4, s4, t6

            addi t4, t4, 1
            j getrightsum
        
        rightsumhere:
        beq s3, s4, pivotfound

        addi s2, s2, 1
        j getbothsums
    

    pivotfound:
        la a0, outfmt
        mv a1, s2
        call printf
        j done

    nopivot:
        la a0, outfmt
        li a1, -1
        call printf
        j done
    
    done:
    ld s1, 0(sp)
    ld s2, 8(sp)
    ld s3, 16(sp)
    ld s4, 24(sp)
    ld ra, 32(sp)
    addi sp, sp, 48

li a0, 0
ret
