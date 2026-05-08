.section .rodata
scan_str: .string "%lld %lld"
print_str: .string "%lld %lld\n"

.section .text
.globl main 

main: 
    addi sp, sp, -64
    sd ra, 56(sp)   # store ra
    sd s0, 46(sp)   # store s0 = M
    sd s1, 40(sp)   # store s1 = N 
    sd s2, 32(sp)   # store s2 = GCD
    sd s3, 24(sp)   # store s3 = LCM
    sd s4, 16(sp)   # store s4 = a
    sd s5, 8(sp)    # store s5 = b
    sd s6, 0(sp)    # store s6 = INT_MAX


    addi sp, sp, -16
    la a0, scan_str
    addi a1, sp, 0
    addi a2, sp, 8
    call scanf
    ld s0, 0(sp)    # store s0 = M
    ld s1, 8(sp)    # store s1 = N
    addi sp, sp, 16

    beq s0, s1, equal   # if both numbers are equal, then GCD = LCM = M = N

    

    addi s2, x0, 0  # initialize GCD = 0
    addi s3, x0, 0  # initialize LCM = 0

    j get_lcm

equal:
    addi s2, s0, 0
    addi s3, s0, 0
    j print 



# ===================================================================
#                     CALCULATE THE LCM
# ===================================================================

get_lcm:
    #start from t0=i=max(M, N) 

    blt s0, s1, M_smaller_lcm
    addi t2, s0, 0
    addi t0, s0, 0 # start from M
    addi t1, s1, 0
    j lcm_loop

M_smaller_lcm:
    addi t2, s1, 0
    addi t0, s1, 0 # start from N
    addi t1, s0, 0

lcm_loop:
    rem t4, t2, t0
    rem t5, t2, t1
    beq t4, x0, check_other_lcm
    addi t2, t2, 1
    j lcm_loop

check_other_lcm:
    beq t5, x0, found_lcm
    addi t2, t2, 1
    j lcm_loop

found_lcm:
    addi s3, t2, 0
    j get_gcd

# ===================================================================
#                     CALCULATE THE GCD
# ===================================================================
get_gcd:
    blt s10, s1, M_smaller_gcd
    addi t0, s1, 0
    j gcd_loop

M_smaller_gcd:
    addi t0, s0, 0

gcd_loop:
    addi t6, x0, 1
    beq t0, t6, gcd_is_one

    rem t1, s0, t0 
    rem t2, s1, t0 

    beq t1, x0, check_other_rem

    addi t0, t0, -1
    j gcd_loop

check_other_rem:
    beq t2, x0, found_gcd
    addi t0, t0, -1
    j gcd_loop

found_gcd:
    addi s2, t0, 0
    j print

gcd_is_one:
    addi s2, x0, 1
    j print

# ===================================================================
#                     PRINT THE GCD AND LCM
# ===================================================================


print:
    la a0, print_str
    addi a1, s2, 0 
    addi a2, s3, 0
    call printf 
    
# ===================================================================
#                           CLEANUP
# ===================================================================

done:
    ld s6, 0(sp)
    ld s5, 8(sp)   
    ld s4, 16(sp)   
    ld s3, 24(sp)   
    ld s2, 32(sp)   
    ld s1, 40(sp)   
    ld s0, 48(sp)   
    ld ra, 56(sp)    
    addi sp, sp, 64

    jalr x0, ra, 0
