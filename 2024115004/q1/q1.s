.section .data
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"

ad_n: .quad 0

.section .text
.globl main
main:
addi sp, sp, -32
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)

la a0, fmt_in
la a1, ad_n
call scanf

la t1, ad_n
ld s0, 0(t1)        # s0 = n

slli a0, s0, 3
call malloc
addi s1, a0, 0      # s1 = arr

li s2, 0
inputloop:
bge s2, s0, findsecmax

slli t0, s2, 3
add a1, t0, s1
la a0, fmt_in
call scanf

addi s2, s2, 1
beq x0, x0, inputloop

findsecmax:
li t5, -1000000            # t5 = f
li t6, -1000000            # t6 = s 

li s2, 0            # s2 = i
loop:
bge s2, s0, end

slli t0, s2, 3
add t0, t0, s1
ld t1, 0(t0)        # t1 = arr[i]

bge t6, t1, next    # s >= arr[i] then next
beq t5, t1, next    # f == arr[i] then next

blt t5, t1, both    # f < arr[i] then both

addi t6, t1, 0

next: 
addi s2, s2, 1
beq x0, x0, loop

both:
addi t6, t5, 0
addi t5, t1, 0
beq x0, x0, next

end:
la a0, fmt_out
addi a1, t6, 0
call printf

ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
addi sp, sp, 32

ret
