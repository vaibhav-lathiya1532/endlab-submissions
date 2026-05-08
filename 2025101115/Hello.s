fmt: 
.string "Hello world\n\0"

.globl main   
main:
	addi sp, sp, -16 
	sd ra, 8(sp)

	lla a0, fmt
	call printf

	li a0, 0
	ld ra, 8(sp)
	addi sp, sp, 16
	ret
