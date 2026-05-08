.section .data
fmt_in: .string "%s"
fmt_out: .string "%ld\n"

.section .bss
str: .space 108

.section .text
.global main
main:
addi sp, sp, -48
sd ra, 40(sp)
sd s0, 32(sp)
sd s1, 24(sp)
sd s2, 16(sp)
sd s3, 8(sp)
sd s4, 0(sp)

la a0, fmt_in
la a1, str
call scanf
mv t0, a1
lb s0, 0(t0)          # s0 = char pointer
li sp, 0

char_loop:
beqz t0, loop_done
li t1, 48             # t1 = 0
blt t0, t1, operator  # char < 0 => operator
li t2, 57             # t2 = 9
bgt t0, t2, operator  # char > 9 => operator

digit:
addi sp, sp, -8
sd t0, 0(sp)          # push t0
j next_char

operator:
ld t2, 0(sp)          # pop t2 = right operator
addi sp, sp, 8
ld t1, 0(sp)          # pop t1 = left operator
addi sp, sp, 8

li t3, 43
beq t0, t3, add_op    # char = +
li t4, 45
beq t0, t4, sub_op    # char = -

mul_op:
mul t0, t1, t2        # t0 = t1*t2
j digit

add_op:
add t0, t1, t2        # t0 = t1+t2
j digit

sub_op:
sub t0, t1, t2        # t0 = t1-t2
j digit

next_char:
addi s0, s0, 1
j char_loop

loop_done:
ld s2, 0(sp)
addi sp, sp, 8

la a0, fmt_out
mv a1, s2
call printf

ld ra, 40(sp)
ld s0, 32(sp)
ld s1, 24(sp)
ld s2, 16(sp)
ld s3, 8(sp)
ld s4, 0(sp)
addi sp, sp, 48
li a0, 0
ret
