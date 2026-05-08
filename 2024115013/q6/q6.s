.section .rodata
ld_n: .asciz "%ld\n"

.section .text
.globl main
main:
	addi sp, sp, -16
	sd ra, 8(sp)
	sd s0, 0(sp)
.loop:
	call getchar
	mv s0, a0  # s0 = inputted char
	call isspace
	bnez a0, .loop_end
	li t0, -1
	beq s0, t0, .loop_end

	li t0, '+'
	beq s0, t0, .add 
	li t0, '-'
	beq s0, t0, .sub 
	li t0, '*'
	beq s0, t0, .mul 
	
	addi s0, s0, -'0'
	# using double the stack space to ensure alignment lol	
	addi sp, sp, -16
	sd s0, 0(sp)
	j .loop
.add:
	ld t1, 0(sp)
	ld t0, 16(sp)
	addi sp, sp, 16
	add t0, t0, t1
	sd t0, 0(sp)
	j .loop
.sub:
	ld t1, 0(sp)
	ld t0, 16(sp)
	addi sp, sp, 16
	sub t0, t0, t1
	sd t0, 0(sp)
	j .loop
.mul:
	ld t1, 0(sp)
	ld t0, 16(sp)
	addi sp, sp, 16
	mul t0, t0, t1
	sd t0, 0(sp)
	j .loop
.loop_end:
	la a0, ld_n
	ld a1, 0(sp)
	call printf

	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	mv a0, zero
	ret

