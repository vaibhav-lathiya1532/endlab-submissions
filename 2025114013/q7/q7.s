.section .rodata
    llint: .string "%lld"
	printll: .string "%lld\n"
    print_true: .string "TRUE\n"
    print_false: .string "FALSE\n"

.section .bss
    n: .space 8

.section .text
.global main

main:
    la a0, llint
    la a1, n
    call scanf

    la s0, n
    ld s0, 0(s0)

    # finding number of digits
    initdigitcount:
        mv t0, s0
        li s1, 0
        li s2, 10

    digitcount:
        beq t0, zero, initdisarium
        div t0, t0, s2
        addi s1, s1, 1
        j digitcount
    
    initdisarium:
        mv s4, s1	# copy of digit total (for iterator)
		mv s5, s0	# copy of number (to supply digits)
		li s3, 0	# final value to compare

	disarium:
		beq s4, zero, evaluate
		# while(i > 0)
		
		findingdigit:
			mv s7, s4
			li s8, 1
			rem s6, s5, s2
			div	s5, s5, s2

		# s6 => digit

		power:
			beq s7, zero, accumulate
			mul s8, s8, s6 
			addi s7, s7, -1

			j power
			# la a0, printll
			
		accumulate:
			add s3, s3, s8

		addi s4, s4, -1
		j disarium

	evaluate:
		beq s3, s0, foundtrue
		bne s3, s0, foundfalse

		foundtrue:
			la a0, print_true
			call printf
			ret
		
		foundfalse:
			la a0, print_false
			call printf
			ret