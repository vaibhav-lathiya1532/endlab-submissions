.data
N: .space 8
target: .space 8
input: .asciz "%lld"
output: .asciz "%lld\n"
arr: .space 800000
fail: .asciz "-1\n"

.text
.globl main

main:
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)

    #first accept N
    la a0, input
    la a1, N
    call scanf

    la a1, N
    ld s0, 0(a1)  #Now s0 has N
    li t0, 8
    mul s2, s0, t0 # s2 has 8*N

    la s1, arr #now s1 is the array
    li s4, 0 #s4 will store the offset

take_input:
    bge s4, s2, get_target 

    la a0, input
    add s5, s4, s1
    mv a1, s5
    call scanf

    addi s4, s4, 8
    j take_input
    
get_target:
    la a0, input
    la a1, target
    call scanf

    la a0, target
    ld s4, 0(a0) #target is in s4

find_target:
    li t0, 0 #t0 is low pointer

    mv t2, s0 #t2 is high pointer index(not in bytes so need to shift by 8 everytime)
    addi t2, t2, -1

loop:
    beq s4, t4, found
    add t1, t0, t2
    li t3, 2
    div t1, t1, t3 #t1 is mid pointer 



    slli t3, t0, 3
    add t3, t3, s1
    ld t3, 0(t3) #t3 is value at low pointer
     

    slli t4, t1, 3
    add t4, t4, s1
    ld t4, 0(t4) #t4 is value at mid pointer

    slli t5, t2, 3
    add t5, t5, s1
    ld t5, 0(t5) #t5 is value at high pointer

    beq s4, t4, found
    bge t0, t1, check
    bge t1, t2, check    
    bgt t3, t4, first_half_not_sorted
    bgt s4, t4, discard_first_half 
    blt t3, t4, discard_second_half


first_half_not_sorted:
    addi t6, t1, 8 
    slli t6, t6, 3
    add t6, t6, s1
    ld t6, 0(t6) #t6 is value at mid+1

    blt s4, t6, discard_second_half
    bgt s4, t5, discard_second_half
    j discard_first_half





discard_first_half:
    mv t0, t1
    j loop

discard_second_half:
    mv t2, t1
    j loop

check:
    beq s4, t4, found
    j done


done:
    la a0, fail
    call printf
    j end


found:
    la a0, output
    addi a1, t1, 0
    call printf



end:
    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    addi sp, sp, 80

    li a7, 93
    li a0, 0
    ecall

