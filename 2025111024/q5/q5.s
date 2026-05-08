.data
n : .dword 0
fmt: .string "%lld"
fmtop: .string "%lld "
fmtsp : .string "%lld\n"

.text
.globl main

main:
    addi sp, sp, -112
    sd ra, 104(sp)
    sd s0, 96(sp)
    sd s1, 88(sp)
    sd s2, 80(sp)
    sd s3, 72(sp)
    sd s4, 64(sp)
    sd s5, 56(sp)
    sd s6, 48(sp)
    sd s7, 40(sp)
    sd s8, 32(sp)
    sd s9, 24(sp)
    sd s10, 16(sp)
    sd s11, 8(sp)

    #input
    la a0, fmt
    la a1, n
    call scanf

    la t0, n
    ld s0, 0(t0) #s0 stores n

    mul t0, s0, s0
    slli t0, t0, 3
    add a0, t0, x0
    call malloc

    add s1, a0, x0 #s1 contains the base memory address of the matrix

    #input matrix
    add s2, x0, x0 #s2 = i
    inloop1:
        beq s2, s0, exitinloop1
        add s3, x0, x0 #s3 = j
        inloop2:
            beq s3, s0, exitinloop2
            mul s4, s0, s2
            add s4, s4, s3
            slli s4, s4, 3 #stores offset
            add s4, s1, s4

            la a0, fmt
            add a1, x0, s4
            call scanf

            addi s3, s3, 1
            j inloop2
        exitinloop2:
            addi s2, s2, 1
            j inloop1
    exitinloop1:

    #transpose of matrix
    
    add s2, x0, x0 #s2 = i
    trans1:
        beq s2, s0, exittrans1
        add s3, x0, x0 #s3 = j
        trans2:
            beq s3, s0, exittrans2
            bge s2, s3, sk
            mul t1, s0, s2
            add t1, t1, s3
            slli t1, t1, 3
            add t1, s1, t1
            ld s5, 0(t1) #s5 = arr[i][j]

            mul t2, s0, s3
            add t2, t2, s2
            slli t2, t2, 3
            add t2, s1, t2
            ld s6, 0(t2) #s6 = arr[j][i]

            sd s6, 0(t1)
            sd s5, 0(t2)

            sk:
                addi s3, s3, 1
                j trans2
        exittrans2:
            addi s2, s2, 1
            j trans1
    exittrans1:

    #reverse each row

    add s2, x0, x0 #s2 = i
    srai s7, s0, 1 # s7 = n/2

    rev1:
        beq s2, s0, exitrev1
        add s3, x0, x0 #s3 = j
        rev2:
            beq s3, s7, exitrev2

            mul t1, s0, s2
            add t1, t1, s3
            slli t1, t1, 3
            add t1, s1, t1
            ld s5, 0(t1) #s5 = arr[i][j]

            sub s8, s0, s3
            addi s8, s8, -1

            mul t2, s0, s2
            add t2, t2, s8
            slli t2, t2, 3
            add t2, s1, t2
            ld s6, 0(t2) #s6 = arr[i][n-j-1]

            sd s6, 0(t1)
            sd s5, 0(t2)
            addi s3, s3, 1
            j rev2
        exitrev2:
            addi s2, s2, 1
            j rev1
    exitrev1:

    #print matrix
    add s2, x0, x0 #s2 = i
    addi s9, s0, -1 #s9 = n-1
    outloop1:
        beq s2, s0, exitoutloop1
        add s3, x0, x0 #s3 = j
        outloop2:
            beq s3, s0, exitoutloop2
            beq s3, s9, print_nsp

            mul s4, s0, s2
            add s4, s4, s3
            slli s4, s4, 3
            add s4, s1, s4

            ld s10, 0(s4)

            la a0, fmtop
            add a1, x0, s10
            call printf

            addi s3, s3, 1
            j outloop2

            print_nsp:
                mul s4, s0, s2
                add s4, s4, s3
                slli s4, s4, 3
                add s4, s1, s4

                ld s10, 0(s4)

                la a0, fmtsp
                add a1, x0, s10
                call printf

                addi s3, s3, 1
                j outloop2
        exitoutloop2:
            addi s2, s2, 1
            j outloop1
    exitoutloop1:

    finish:

        ld s11, 8(sp)
        ld s10, 16(sp)
        ld s9, 24(sp)
        ld s8, 32(sp)
        ld s7, 40(sp)
        ld s6, 48(sp)
        ld s5, 56(sp)
        ld s4, 64(sp)
        ld s3, 72(sp)
        ld s2, 80(sp)
        ld s1, 88(sp)
        ld s0, 96(sp)
        ld ra, 104(sp)
        addi sp, sp, 112

        add a0, x0, x0
        ret





