.data
fmt_in: .string "%lld"
fmt_val: .string "%lld "
fmt_true: .string "TRUE"
fmt_false: .string "FALSE"

.text
.globl main

main: 
    addi sp, sp, -56
    sd ra, 0(sp)
    sd s0, 8(sp) # <- N
    sd s1, 16(sp) # <- prev indicator
    sd s2, 24(sp) #<- curr indicator
    sd s3, 32(sp) # <- loop counter
    sd s4, 40(sp) # <- current number

    la a0, fmt_in
    addi a0, sp, 0
    call scanf
    ld s0, 0(sp) 

arr: 
    bge s3, s0, true
    mv s1, s2

    
    mv t0, s3
    slli t0, 2
    addi a1, s0, t0
    call scanf
    ld s4, 

    
check_parity:
    li t2, 0
    rem t2, t1, 2

    beqz t2, even

odd:
    li s2, 1

    beqz s3, arr
    bneqz s3, check_alt

even: 
    li s2, 0

    beqz s3, arr


check_alt: 
    mv a0, s1
    mv a1, s2

    add a0, a0, a1
    addi a0, -1

    bneqz a0, false
    j arr

false: 
    la a6, fmt_false
    mv a7, 0
    call printf

    j done

true:
    la a6, fmt_true
    mv a7, 0
    call printf

done:
    addi sp, sp, 56
    ld ra 0(sp)
    ld s0 8(sp) 
    ld s1 16(sp) 
    ld s2 24(sp)
    ld s3, 32(sp)
    ld s4, 40(sp)

    li a0, 0
    ret