.section .rodata
    input: .string "%lld"
    outputyes: .string "TRUE\n"
    outputno: .string "FALSE\n"

.section .text
.globl main

main:
    addi sp, sp, -48
    sd ra, 8(sp)
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)
    sd s3, 40(sp)

    lla a0, input
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp) # number

    mv t0, s0
    mv t2, s0
    li s1, 0 # length
    li t1, 10
    li s2, 0
len:
    beqz t0, loop
    div t0, t0, t1
    addi s1, s1, 1
    j len

loop:
    beqz s1, end

    rem t3, t2, t1
    li t4, 1
    li t5, 0
    multiloop:
        bge t5, s1, next
        mul t4, t4, t3
        addi t5,t5,1
        j multiloop
    
    next:
    add s2, s2, t4
    div t2, t2, t1
    addi s1, s1, -1
    j loop

end:
    beq s2, s0, yes

    lla a0, outputno
    call printf
    addi a0, x0,0

    ld ra, 8(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    ld s3, 40(sp)
    addi sp, sp, 48
    ret

yes:

    lla a0, outputyes
    call printf
    
    addi a0, x0,0
    ld ra, 8(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    ld s3, 40(sp)
    addi sp, sp, 48
    ret
