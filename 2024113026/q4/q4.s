.section .rodata
fmt_in: .asciz "%d %d"
fmt_out: .asciz "%d--%d\n"
fmt_outi: .asciz "loo %d oo\n"
fmt_outiz: .asciz "hi\n"


.section .text
.globl main

main:
addi sp, sp, 20
sd ra , 12(sp)

sd s0 , 0(sp)
sd s1 , 2(sp)

sd s2 , 4(sp)
sd s3 , 6(sp)
sd s4 , 8(sp)
sd s5 , 10(sp)

#input
la a0 , fmt_in
addi a1 , sp , 14
addi a2 , sp , 16
call scanf

ld s0 , 14(sp) # amount
ld s1 , 16(sp) # given

ld s2 , x0
ld s3 , x0
ld s4 , x0
ld s5 , x0

sub s1 , s1, s2  # change

loop:

beq s1,end

bge  s1, 25, twenty_five

bgeu  s1, 10, ten

bgeu  s1, 5, five

bgeu  s1, 1, one

j loop

twenty_five:

