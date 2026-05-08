.section .rodata

input_fmt: .string "%lld"
output_fmt: .string "%lld\n"

.section .bss

n: .space 8
arr: .space 840
prefix: .space 840

.section .text
.globl main

main:
	addi sp, sp, -16
	sd ra, 0(sp)

	la a0, input_fmt
	la a1, n

	call scanf

	la t0, n
	ld s0, 0(t0) # s0 = value of n

	addi s1, x0, 0 # s1 = input loop iteration

	la s2, arr # s2 = base address of arr = &arr[0]
	la s5, prefix # s5 = base address of prefix = &prefix[0]	

input_loop:
	beq s1, s0, setup_prefix
		
	slli s4, s1, 3 # s4 = array offset
	add s4, s4, s2 # s4 = address of current element of array

	la a0, input_fmt
	addi a1, s4, 0

	call scanf

	addi s1, s1, 1
	j input_loop

setup_prefix:
	addi t0, x0, 1 # t0 is iteration counter
	
	ld t1, 0(s2) # t1 = value of arr[0]
	sd t1, 0(s5) # prefix[0] = arr[0]

	j build_prefix

build_prefix:
	beq t0, s0, check_loop_setup

	slli t1, t0, 3 # t1 = t0 * 8 = offset

	add t2, t1, s2 # t2 = address of arr[i] = &arr[i]

	add t3, s5, t1 # t3 = &prefix[i]
	addi t3, t3, -8 # t3 = &prefix[i - 1]
	
	ld s10, 0(t2) # s10 = arr[i]
	ld s11, 0(t3) # s11 = prefix[i - 1]

	add t5, s10, s11 # t5 = arr[i] + prefix[i - 1]

	add t4, t1, s5 # t4 = &prefix[i]

	sd t5, 0(t4)
	
	addi t0, t0, 1
	j build_prefix
	
check_loop_setup:
	addi t0, x0, 0 # t0 is the iteration counter
	
	addi t1, s0, -1 # t1 = n - 1
	slli t1, t1, 3 # t1 = (n - 1) * 8

	add t2, s5, t1 # t2 = &prefix[0] + (n - 1) * 8 = address of last element
	ld s9, 0(t2) # s9 = prefix[n - 1]

	j check_loop

check_loop:
	beq t0, s0, notfound

	slli t1, t0, 3 # t1 is the offset
	add t1, t1, s5 # t1 = &prefix[i]
	
	ld t2, 0(t1) # t2 = prefix[i]
	sub t3, s9, t2 # s9 = prefix[n - 1] - prefix[i]

	beq t0, x0, first_elem

	addi t1, t1, -8 # t1 = &prefix[i - 1]
	ld t4, 0(t1) # t4 = prefix[i - 1]

	j check_loop_after

first_elem:
	addi t4, x0, 0 # t4 is the value of prefix[i - 1] which is 0 when i = 0
	j check_loop_after

check_loop_after:
	beq t3, t4, found
	
	addi t0, t0, 1
	j check_loop

found:
	la a0, output_fmt
	addi a1, t0, 0

	call printf

	j end	

notfound:
	la a0, output_fmt
	addi a1, x0, -1

	call printf

	j end

end:
	ld ra, 0(sp)
	addi sp, sp, 16
	ret
		






	
