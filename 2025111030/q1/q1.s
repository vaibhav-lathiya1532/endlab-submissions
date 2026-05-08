.section .rodata
num_inp:
    .string "%lld"
num_out:
    .string "%lld\n"
debug:
    .string "here\n"

.section .bss
len:
    .space 8
array:
    .space 805

.section .text
.globl main
main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)

    lla a0, num_inp
    lla a1, len
    call scanf

    lla t0, len
    ld s0, 0(t0) # CONST s0 = len

    # s1: largest, s2: 2nd largest

    # scanf loop
    li s3, 0 # s3 = ctr
    loop:

        bge s3, s0, loop_end

        slli t0, s3, 3 # offset

        #scan
        lla a0, num_inp
        lla a1, array
        add a1, a1, t0
        call scanf
        
        addi s3, s3, 1
        j loop
    loop_end:

    lla t0, array
    ld s1, 0(t0)
    li s2, -1000005

    # algo loop
    li s3, 0 # s3 = ctr
    ploop:
        bge s3, s0, ploop_end

        slli t0, s3, 3 # offset
        lla t1, array
        add t1, t1, t0

        ld s4, 0(t1) # s4 = arr[i]

        bgt s4, s1, greater
        beq s4, s1, conti
        bgt s4, s2, greater_
        j conti
        
        # update s2 if s1 updates
        greater:
            mv s2, s1
            mv s1, s4
            j conti
        greater_:
            mv s2, s4

        conti:
        addi s3, s3, 1
        j ploop

    ploop_end:

    lla a0, num_out
    mv a1, s2
    call printf

    ld ra, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    addi sp, sp, 80
    li a0, 0
    ret
