.section .data
f_in: .string "%lld"
f_out: .string "%lld\n"

.section .bss
arr: .space 800000

.section .text
.globl main

main:
    #start
    addi sp, sp, -32
    sd   ra, 0(sp)
    sd   s0, 8(sp)
    sd   s1, 16(sp)

    #scanf
    la   a0, f_in
    addi sp, sp, -16
    mv   a1, sp
    call scanf

    # store n
    ld   s0, 0(sp)
    addi sp, sp, 16

    #store arr
store:
    bgt  s1, s0, s_done
    li   s1, 0    #i = 0 for loop
    la   s2, arr
    slli t0, s1, 3
    add  t0, s2, t0  #t0 is pointer to array(temporarly)

    #scanf
    la   a0, f_in
    mv   a1, t0
    call scanf

    ld   t0, 0(t0)
    addi s1, s1, 1
    j    store
s_done:

    #store target
    #scanf
    la   a0, f_in
    addi sp, sp, -16
    mv   a1, sp
    call scanf

    ld s1, 0(sp) #s1 = target

    addi sp, sp, 16

    
    #binary search
    mv   s3, s2      #s3 = [left]
    slli t0, s0, 3  
    add  s4, s2, t0  #s4 = [right]

    ld t0, 0(s3) #t0 = arr[left]
    ld t1, 0(s4) #t1 = arr[right]
    li s6, -1
    
bsearch:
    beq s1, t2, found

    add  s5, s3, s4
    srai s5, s5, 1   #s5 = mid
    ld   t2, 0(s5)   #t2 = arr[mid]

    bge t2, s1, right_sorted
    blt s1, t0, right_sorted

    bgt s1, t2, go_right
    j    bsearch

go_right:
    addi s3, s5, 1
    j    bsearch

right_sorted:
    addi s3, s5, 1
    j    bsearch

found:
    mv s6, s5

    #printf
    la a0, f_out
    mv a1, s6

    ld   ra, 0(sp)
    ld   s0, 8(sp)
    ld   s1, 16(sp)
    addi sp, sp, 32
    ret


    
    





    






