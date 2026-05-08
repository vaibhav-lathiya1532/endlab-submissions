.section .rodata
fmt_in: .string"%d"
fmt_out: .string"%d\n"

.section .text
.global main

main
add sp, sp, -16
lla a0, fmt_in
addi a1, sp, 8 #
call scanf
lw t0, 0(sp)

add sp, sp, -16
lla a0, fmt_in
addi a1, sp, 8 #
call scanf
lw t6, 0(sp)



li t1, 1
loop:
beq t1, t0, done
mul t3, t1, 8
lla a0, fmt_in
add a1, sp, t3 
call scanf
done:

li t3, 0
li t4, 0
addi t5, t0, 0 
pool:
beq t5, t4, enod
jal ra



enod:


