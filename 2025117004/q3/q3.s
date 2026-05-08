.data
fmt: .asciz " %lld"
fmt_out: .asciz "%lld"
array: .space 8410
num: .dword 0 
.text 
.globl main 

main: 
    addi sp, sp, -120 
    sd ra, 0(sp)
    

    
    la a0, fmt 
    la a1, num 
    call scanf 

    la t0, num 
    ld s1, 0(t0)   
    li s2, 0
    la s3, array 
    ld x0, 0(s3)
    addi s4, x0, 0
    # s1 =n , s2 = i, s3 = array base, s4 = curr sum 
loop: 
    beq s1, s2, loop_done 
    la a0, fmt 
    la a1, num 
    call scanf 
    la t0, num 
    ld t0, 0(t0)
    add s4, s4, t0 
    add t1, s2, 0 
    slli t1, t1, 3 
    add t1, t1, s3 
    sd s4, 0(t1) 
    addi s2, s2, 1

    j loop 

loop_done: 
    la a0, fmt_out 
    mv a1, s4 

# s4 has middle
    addi s2, x0, 0 
loop2: 
    beq s1, s2, not_found
    addi t1, s2, 0 
    slli t1, t1, 3 
    add t1, t1, s3 
    ld t0, 0(t1)
    sub t0, s4, t0

    addi t1, s2, -1  
    slli t1, t1, 3 
    add t1, t1, s3 
    ld t1, 0(t1) 

    beq t0, t1, found 
    addi s2, s2, 1
    j loop2
not_found: 
    addi a1, x0, -1 
    la a0, fmt_out
    call printf 
    j done 
found: 
    mv a1, s2 
    la a0, fmt_out 
    call printf 
    j done 
done: 
    ld ra,0(sp)
    addi sp, sp, 120
    