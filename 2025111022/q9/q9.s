.data
    fmtint: .string "%lld"
    fmtout: .string "%lld\n"
    n: .quad 0

.text
.globl main
main:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd s0, 8(sp)   #input string
    sd s1, 0(sp)    #sum

    la a0, fmtint
    la a1, n
    call scanf
    ld s0, n

    li t0, 100  #iter count
    li t1, 0   #i
    li s1, 0

loop:
    ble t0, x0, invalid

    beq s0, x0, next

    li t5, 10
    remu t2, s0, t5
    divu s0, s0, t5

    mul t2, t2, t2
    add s1, t2, s1
    j loop

next:
    li t5, 1
    beq s1, t5, win
    mv s0, s1
    li s1, 0
    addi t0, t0, -1
    j loop

invalid:    
    la a0, fmtout
    li a1, 0
    call printf
    
    ld s1, 0(sp)
    ld s0, 8(sp)
    ld ra, 16(sp)
    addi sp, sp, 24
    ret

win:
    la a0, fmtout
    li a1, 1
    call printf

    ld s1, 0(sp)
    ld s0, 8(sp)
    ld ra, 16(sp)
    addi sp, sp, 24
    ret
