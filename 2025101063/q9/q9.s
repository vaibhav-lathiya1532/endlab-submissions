.section .rodata
scan_fmt: .string "%lld"
one: .string "1\n"
zero: .string "0\n"

.global main
.text

main:
    addi sp, sp, -32
    sd x1, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)

    lla a0, scan_fmt
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)        #s0 = n

    mv t0, s0           #t0 = n
    addi t1, x0, 100    #t1 = 100
    addi t2, x0, 10     #t2 = 10

    beqz t0, sad

loop:
    mv t0, s0
    addi t3, x0, 1
    beq t0, t3, happy
    beqz t1, sad
    addi t1, t1, -1     #i--
    addi s0, x0, 0

ele:
    beqz t0, loop
    rem t4, t0, t2
    mul t5, t4, t4
    add s0, s0, t5
    div t0, t0, t2
    j ele

sad:
    lla a0, zero
    call printf
    j end

happy:
    lla a0, one
    call printf

end:
    ld x1, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    addi sp, sp, 32
    ret
