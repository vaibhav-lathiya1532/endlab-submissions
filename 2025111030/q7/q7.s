.section .rodata
num_inp:
    .string "%lld"
num_out:
    .string "%lld\n"
debug:
    .string "here\n"
str_inp:
    .string "%s"
eq_out:
    .string "TRUE\n"
not_eq_out:
    .string "FALSE\n"

.section .bss
str:
    .space 20

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
    sd s6, 48(sp)
    sd s7, 56(sp)

    # string input
    lla a0, str_inp
    lla a1, str
    call scanf

    # string loop
    li s0, 0 # s0 = ptr
    li s2, 0 # s2 = TOTAL SUM
    li s7, 0
    str_loop:
        lla t0, str
        add t0, t0, s0 # add offset
        lb s1, 0(t0) # s1 = str[i] [IMP]

        beqz s1, str_loop_end # check end of string

        addi s1, s1, -48 # convert to int

        li t5, 10
        mul s7, s7, t5
        add s7, s7, s1

        # pow_loop_init
        li s3, 1 # s3 = MUL per char
        addi s4, s0, 1 # s4 = COUNTER
        # s1 = current num

        pow_loop:
            beqz s4, pow_loop_end
            mul s3, s3, s1
            addi s4, s4, -1
            j pow_loop

        pow_loop_end:
            add s2, s2, s3 # update SUM
            addi s0, s0, 1 # advance ptr
            j str_loop

    str_loop_end:

    beq s2, s7, equal
    lla a0, not_eq_out
    call printf
    j finish

    equal:
        lla a0, eq_out
        call printf

    finish:
    ld ra, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    addi sp, sp, 80
    li a0, 0
    ret
