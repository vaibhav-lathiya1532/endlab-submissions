.section .rodata
ld: .asciz "%ld"
ld_n: .asciz "%ld\n"

.section .text
is_prime:
	srai t0, a0, 1 
	beqz t0, .ipno
	li t0, 2 # counter
.ipl:
	bge t0, a0, .ipyes
	rem t1, a0, t0
	beqz t1, .ipno
	addi t0, t0, 1
	j .ipl
.ipno:
	mv a0, zero
	ret
.ipyes:
	li a0, 1
	ret

.globl main
main:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	sd s1, 24(sp)
	sd s2, 16(sp)
	sd s3, 8(sp)

	la a0, ld
	mv a1, sp
	call scanf
	ld s0, 0(sp)  # s0 = n

	slli a0, s0, 3
	call malloc
	mv s1, a0  # s1 = arr

	mv s2, zero # counter
.load_arr:
	bge s2, s0, .load_arr_end
	la a0, ld
	slli a1, s2, 3
	add a1, a1, s1
	call scanf 
	addi s2, s2, 1
	j .load_arr
.load_arr_end:
	mv s2, zero # sum
	mv s3, zero # counter
.sum_arr:
	bge s3, s0, .sum_arr_end	
	slli a0, s3, 3
	add a0, a0, s1
	ld a0, 0(a0)
	mv a1, a0
	call is_prime	
	mul a1, a1, a0
	add s2, s2, a1
	addi s3, s3, 1
	j .sum_arr
.sum_arr_end:
	la a0, ld_n
	mv a1, s2
	call printf
	ld ra, 40(sp)
	ld s0, 32(sp)
	ld s1, 24(sp)
	ld s2, 16(sp)
	ld s3, 8(sp)
	addi sp, sp, 48
	mv a0, zero
	ret
