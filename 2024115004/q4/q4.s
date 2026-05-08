.section .data
fmt_in: .asciz "%lld %lld"
fmt_out: .asciz "%lld %lld %lld %lld\n"

ad_price: .quad 0
ad_inserted: .quad 0

.section .text
.globl main
main:
addi sp, sp, -16
sd ra, 8(sp)
sd s0, 0(sp)

la a0, fmt_in
la a1, ad_price
la a2, ad_inserted
call scanf

la t1, ad_price
ld t2, 0(t1)        # t2 = price
la t3, ad_inserted
ld t4, 0(t3)        # t4 = inserted

sub t0, t4, t2      # t0 =diff

li t1, 0            # t1 = 25c
li t3, 0            # t3 = 10c
li t5, 0            # t5 = 5c
li t6, 0            # t6 = 1c

floop:
li s0, 25
blt t0, s0, sloop
addi t0, t0, -25
addi t1, t1, 1
beq x0, x0, floop

sloop:
li s0, 10
blt t0, s0, tloop
addi t0, t0, -10
addi t3, t3, 1
beq x0, x0, sloop

tloop:
li s0, 5
blt t0, s0, lloop
addi t0, t0, -5
addi t5, t5, 1
beq x0, x0, tloop

lloop:
li s0, 1
blt t0, s0, end
addi t0, t0, -1
addi t6, t6, 1
beq x0, x0, lloop

end:
la a0, fmt_out
addi a1, t1, 0
addi a2, t3, 0
addi a3, t5, 0
addi a4, t6, 0
call printf


ld ra, 8(sp)
ld s0, 0(sp)
addi sp, sp, 16

ret
