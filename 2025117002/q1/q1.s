.data
    fmt_ll: .string "%lld"
    fmt_true: .string "TRUE\n"
    fmt_false: .string "FALSE\n"

.text
.global main

main:
    addi sp, sp, -48
    sd ra, 0(sp) #
    sd s0, 8(sp) # N
    sd s3, 16(sp) #arr_add
    sd s1, 24(sp) #i=0

    la a0, fmt_ll
    addi a0, sp, 32
    call scanf
    ld s0, a0

    li s2, 0
    j check_start

check_start:
    beq s1, s0, same
    
    la a0, fmt_ll
    addi a0, sp, 24
    call scanf
    ld a1, a0

    li t4, 1
    and a1, a1, t4

    beq a1, s3, not_same
    mv s3, a1

same:
    la a0, fmt_true
    call printf
    j done

not_same:
    la a0, fmt_false
    call printf
    j done

done:
    ld ra, 0(sp) #
    ld s0, 8(sp) # N
    ld s3, 16(sp) #arr_add
    ld s1, 24(sp) #i=0
    addi sp, sp, -48
    ret


