.section .rodata
fmt_in: .string "%lld"
fmt_true: .string "TRUE\n"
fmt_false: .string "FALSE\n"

.text
.global main


main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)
    sd s7, 8(sp)
    sd s8, 0(sp)


    addi sp, sp, -16
    lla a0, fmt_in
    addi a1, sp, 0
    call scanf

    ld s0, 0(sp)
    addi sp, sp, 16


    beq s0, x0, print_yes
    
    li s4, 1
    li s1, 1

    addi sp, sp, -16
    lla a0, fmt_in
    addi a1, sp, 0
    call scanf

    ld s3, 0(sp)
    addi sp, sp, 16


    andi t0, s3, 1
    beq t0, x0, even_inp
    bne t0, x0, odd_inp




odd_inp:
    li s2, 1
    jal x0, inp_loop

even_inp:
    li s2, 0
    jal x0, inp_loop



inp_loop:
    beq s0, s4, print_ans
    
    addi sp, sp, -16
    lla a0, fmt_in
    addi a1, sp, 0
    call scanf

    ld s3, 0(sp)
    addi sp, sp, 16
    
    addi s4, s4, 1

    beq s1, x0, inp_loop

    andi t0, s3, 1

    beq s2, t0, update_false
    bne s2, t0, update_prev_state

update_prev_state:
    beq t0, x0, even_inp
    bne t0, x0, odd_inp


update_false:
    li s1, 0
    jal x0, update_prev_state




print_ans:
    beq s1, x0, print_no
    bne s1, x0, print_yes



print_yes:
    lla a0, fmt_true
    call printf
    jal x0, Exit

print_no:
    lla a0, fmt_false
    call printf
    jal x0, Exit



Exit:
    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    ld s7, 8(sp)
    ld s8, 0(sp)
    addi sp, sp, 80

    ret


