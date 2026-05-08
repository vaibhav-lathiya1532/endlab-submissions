.data
    fmt_lld: .string "%lld"
    fmt_true: .string "TRUE\n"
    fmt_false: .string "FALSE\n"
    fmt_char: .string "%c"
    num_string: .string "%s"

.text
.global main

main:
    addi sp, sp, -16
    sd ra, 8(sp)

    la a0, fmt_lld
    addi a1, sp, 0
    call scanf
    ld a0, 0(sp) #a0 = N
    
    li a4, 0
    mv a2, a0
    li a3, 1 #digits
    j get_digit_count

get_digit_count:
    li t0, 10
    div a2, a2, t0
    ble a2, x0, pre_disarium
    addi a3, a3, 1
    j get_digit_count

pre_disarium:
    mv t0, a0 #t0 = N/10^i
    mv t1, a3 #digit count
    li t2, 10
    li t5, 1
    j disarium

disarium:
    ble t1, x0, check_same
    rem t3, t0, t2
    mv t4, t1
    j get_power

get_power:
    ble t4, x0, next
    mul t5, t5, t3
    addi t4, t4, -1
    j get_power

next:
    add a4, a4, t5
    li t5, 1
    div t0, t0, t2
    addi t1, t1, -1
    j disarium

check_same:
    beq a4, a0, same
    j not_same

same:
    la a0, fmt_true
    call printf
    j done

not_same:
    la a0, fmt_false
    call printf
    j done

done:
    ld ra, 8(sp)
    addi sp, sp, 16
    ret