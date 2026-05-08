main:
    la a7, 5
    ecall

    ld s0, a0
    addi s1, s0, 0

    li s2, 1 #counter

loop:
    li t0, 1
    beq s1, t0, is_happy

    li t0, 100
    beq t0, s2, is_not_happy

    li t0, 9
    ble s1, t0, one_digit

    li t0, 99
    ble s1, t0, two_digits

    li t0, 999
    ble s1, t0, three_digits

    li t0, 9999
    ble s1, t0, four_digits

    li t0, 99999
    ble s1, t0, five_digits

one_digit:
    mul s1, s1, s1
    j increment_loop

two_digits:
    li t0, 10
    beq s1, t0, is_happy

    li t0, 19
    beq s1, t0, is_happy

    li t0, 68
    beq s1, t0, is_happy

    li t0, 82
    beq s1, t0, is_happy

    li s4, 0 #temp sum
    
    andi s3, s1, 15
    
    ble s3, 9, square

    sub s3, s3, 10

three_digits:
    li t0, 100
    beq t0, s1, is_happy

    j is_not_happy

four_digits:
    li t0, 1000
    beq t0, s1, is_happy

    j is_not_happy

five_digits:
    li t0, 10000
    beq t0, s1, is_happy

    j is_not_happy

square:
    mul t0, s3, s3
    add s4, s4, t0

two_digits_part_two:
    sub s5, s1, s3

    j is_not_happy
    

increment_loop:
    addi s2, s2, 1
    j loop

is_happy:
    li a0, 1
    la a7, 5
    ecall
    j end

is_not_happy:
    li a0, 0
    la a7, 5
    ecall
    j end

end:
    ret