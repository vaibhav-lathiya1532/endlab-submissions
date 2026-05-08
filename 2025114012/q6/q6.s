.section .rodata

input_fmt: .string "%s"
output_fmt: .string "%lld\n"

.section .bss
expr: .space 101

.section .text
.globl main

main:
	addi sp, sp, -8
	sd ra, 0(sp)
	
	la a0, input_fmt
	la a1, expr

	call scanf

	la s0, expr # s0 = &expr[0]
	addi s1, x0, 0 # s1 is the loop iterator AND the offset

	addi s4, x0, 43 # s4 = '+'
	addi s5, x0, 45 # s5 = '-'
	addi s6, x0, 42 # s6 = '*'
	addi s7, x0, 47 # s7 = '/'

	addi s2, x0, 0 # s2 = bytes allocated after ra

process_loop:
	add t0, s1, s0 # t0 is the address of current char
	lb t1, 0(t0) # t1 = expr[i]

	beq t1, x0, end
	
	beq t1, s4, plus
	beq t1, s5, minus
	beq t1, s6, multi
	beq t1, s7, divide

	j else

plus:
	ld t0, 0(sp) # t0 = first operand
	addi sp, sp, 8
	
	ld t1, 0(sp) # t1 = second operand
	addi sp, sp, 8

	add t2, t1, t0
	
	addi sp, sp, -8 
	sd t2, 0(sp) # push t0 + t1 onto the stack

	addi s2, s2, -8 # 8 bytes removed in total

	addi s1, s1, 1	
	j process_loop

minus:
	ld t0, 0(sp) # t0 = first operand
	addi sp, sp, 8
	
	ld t1, 0(sp) # t1 = second operand
	addi sp, sp, 8

	sub t2, t1, t0
	
	addi sp, sp, -8 
	sd t2, 0(sp) # push t1 - t0 onto the stack

	addi s2, s2, -8 # 8 bytes removed in total

	addi s1, s1, 1	
	j process_loop

multi:
	ld t0, 0(sp) # t0 = first operand
	addi sp, sp, 8
	
	ld t1, 0(sp) # t1 = second operand
	addi sp, sp, 8

	mul t2, t1, t0
	
	addi sp, sp, -8 
	sd t2, 0(sp) # push t0 * t1 onto the stack

	addi s2, s2, -8 # 8 bytes removed in total

	addi s1, s1, 1	
	j process_loop

divide:
	ld t0, 0(sp) # t0 = first operand
	addi sp, sp, 8
	
	ld t1, 0(sp) # t1 = second operand
	addi sp, sp, 8

	div t2, t1, t0
	
	addi sp, sp, -8 
	sd t2, 0(sp) # push t1 / t0 onto the stack

	addi s2, s2, -8 # 8 bytes removed in total

	addi s1, s1, 1	
	j process_loop

else:
	addi sp, sp, -8
	
	addi t1, t1, -48
	sd t1, 0(sp)
	
	addi s2, s2, 8

	addi s1, s1, 1	
	j process_loop

end:
	ld t0, 0(sp)

	la a0, output_fmt
	addi a1, t0, 0

	call printf

	add sp, sp, s2 # reclaiming the space on stack

	ld ra, 0(sp)
	addi sp, sp, 8
	ret
	
		
	

	
	
	
