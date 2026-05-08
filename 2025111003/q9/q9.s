.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.section .text
.global main

main:
    addi sp, sp, -48
    sd ra, 0(sp)
    # 8 - scanf
    sd s0, 16(sp) # i
    sd s1, 24(sp) # max iter
    sd s2, 32(sp) # n
    sd s3, 40(sp) # sum
    la a0, fmt_in
    addi a1, sp, 8

    call scanf

    ld s2, 8(sp)

    mv s0, x0
    li s1, 100

    j happy

happy:
    beq s0, s1, notfound
    mv s3, x0
    j sumsq

sumsq:
    ble s2, x0, happy_end
    li t0, 10
    rem t1, s2, t0 # n % 10
    mul t1, t1, t1 # dig * dig
    add s3, s3, t1 # sum += dig*dig
    div s2, s2, t0 # n /= 10

    j sumsq

happy_end:
    li t2, 1
    beq s3, t2, found
    mv s2, s3
    addi s0, s0, 1
    j happy

notfound:
    li a1, 0
    j end

found:
    li a1, 1
    j end

end:
    la a0, fmt_out
    call printf

    ld ra, 0(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    ld s3, 40(sp)

    addi sp, sp, 48
    mv a0, x0
    ret

