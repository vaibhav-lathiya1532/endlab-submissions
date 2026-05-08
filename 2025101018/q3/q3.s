.data
    fmt: .string "%ld"
    fmtspc: .string " "
    fmtnl: .string "\n"
    fmtout: .string "%ld\n"
    debug: .string "AAH\n"

.text

.globl main
main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)
    sd s5, 48(sp)
    sd s6, 56(sp)
    la a0, fmt
    addi a1, sp, 8
    call scanf
    ld s0, 8(sp)
    li s2, 0 #s2= sum

loop:
    beqz s0, fin
    la a0, fmt
    addi a1, sp, 32
    call scanf
    ld s3, 32(sp)    #s3= number
    srli s4, s3, 1 #s4= s3/2
    li s5, 2 # s5=j
    li s6, 1
    beq s6, s3, bottom_loop

loop_in:
    bgt s5, s4, add_indeed #prime if j>n/2
    rem t5, s3, s5 # t5= number % j
    beqz t5, bottom_loop #if t5=0, not prime
    addi s5, s5, 1
    j loop_in

    add_indeed:
        add s2, s2, s3
    
bottom_loop:
    addi s0, s0, -1    
    j loop

fin:
    la a0, fmtout
    mv a1, s2
    call printf
    
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)
    ld s5, 48(sp)
    ld s6, 56(sp)
    addi sp, sp, 64
    ret
