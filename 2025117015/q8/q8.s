.section .data
fmt_in: .string "%lld"
N: .dword 0
targ: .dword 0
test: .string "testing\n"
left_right: .string "left: %lld right: %lld\n"

.section .text
.globl main
main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp) #N
    sd s1, 16(sp) #malloc array
    sd s2, 24(sp) #target value
    sd s3, 32(sp) #identified index (where its been rotated)
    sd s4, 40(sp) #final answer
    sd s5, 48(sp)
    sd s6, 56(sp)

    la a0, fmt_in
    la a1, N
    call scanf

    la t0, N
    ld s0, 0(t0)
    #scanned N

    slli a0, s0, 3
    call malloc
    mv s1, a0
    #created an empty array

    li s2, 0
    slli s3, s0, 3

    scan_loop:
        bge s2, s3, scan_done
        la a0, fmt_in
        add a1, s1, s2
        call scanf
        addi s2, s2, 8
        j scan_loop
    
    scan_done:
    
    

    la a0, fmt_in
    la a1, targ
    call scanf

    la t0, targ
    ld s2, 0(t0)
    #done with aquiring target number

    li s3, 1 #index
    ld t5, 0(s1) #start value
    
    identify_index: #loop to identify the index at which the loop has been rotated.
        bge s3, s0, no_rotation
        mv t0, s1
        slli t1, s3, 3
        add t0, t0, t1
        ld t6, 0(t0)
        blt t6, t5, identified
        addi s3, s3, 1
        mv t5, t6
        j identify_index


        identified:
            mv t0, s1
            slli t1, s3, 3
            add t0, t0, t1
            ld t5, 0(t0) #the identified index

            mv t0, s1
            addi t2, s0, -1
            slli t1, t2, 3
            add t0, t0, t1 
            ld t6, 0(t0) #the last value. this is to check which subarray to do binary search in

            blt s2, t6, second_right
            j left_half
            second_right:
                bgt s2, t5, right_half
                j left_half
            

        right_half:
            mv t3, s3
            addi t4, s0, -1
            j binary_search
        
        left_half:
            li t3, 0
            addi t4, s3, -1
            j binary_search
        
        no_rotation:
            li t3, 0
            addi t4, s0, -1
            j binary_search
    
    
    #error here

    binary_search:
        bgt t3, t4, not_found
        #middle index = t5
        #left = t3
        #right = t4

        add t5, t3, t4
        srli t5, t5, 1

        slli t6, t5, 3
        add t6, s1, t6
        ld t6, 0(t6)
        blt s2, t6, smaller
        bgt s2, t6, greater
        
        mv s4, t5
        j search_done

        smaller:
            add t4, t5, -1
            j binary_search
        
        greater:
            add t3, t5, 1
            j binary_search
        
    not_found:
        li s4, -1
        j search_done
    
    search_done:
        la a0, fmt_in
        mv a1, s4
        call printf

    
    ld ra, 0(sp)
    ld s0, 8(sp) 
    ld s1, 16(sp) 
    ld s2, 24(sp) 
    ld s3, 32(sp) 
    ld s4, 40(sp) 
    ld s5, 48(sp)
    ld s6, 56(sp)
    addi sp, sp, 64

    ret
