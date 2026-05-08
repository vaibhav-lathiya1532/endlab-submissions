.data
fmt_in:.string "%lld %lld"
fmt_out:.string "%lld\n"

.text
.global main

main:

addi sp, sp, -56
sd a0, 48(sp)
sd t0, 40(sp)
sd s0, 32(sp)
sd s1, 24(sp)
sd t2, 16(sp)
sd a1, 8(sp)
sd a2, 0(sp)

la a0, fmt_in
addi a1, a1, 0
addi a2, a2, 8
call scanf

ld s0, a1
ld s1, a2

blt s0, s1, reverse
j gcd

reverse:
ld t2, s0
ld s0, s1
ld s1, t2
ld t2, x0
j gcd

gcd:
beq s1, x0, print_gcd
rem t0, s0, s1
ld s0, s1
ld s1, t0
j gcd

print_gcd:
la a0, fmt_out
la a1, s0
call printf 

ld a0, 48(sp)
ld t0, 40(sp)
ld s0, 32(sp)
ld s1, 24(sp)
ld t2, 16(sp)
ld a1, 8(sp)
ld a2, 0(sp)

addi sp, sp, 56
ret

