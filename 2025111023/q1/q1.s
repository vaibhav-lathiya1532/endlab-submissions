.section .rodata
fmt:
.string "%lld"
fmt_true:
.string "TRUE\n"
fmt_false:
.string "FALSE\n"
.globl main
.section .text
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)   #no. of input
    sd s1, 40(sp)   #1st no.
    sd s2, 32(sp)   #2nd no.
    li t0, 2
    li s2, 0
    li t3, 1
read:
    lla a0, fmt
    addi a1, sp, 8
    call scanf
    ld s0, 8(sp)        #s0 has total no of numbers now
    lla a0, fmt
    addi a1, sp, 16
    call scanf
    ld s1, 16(sp)        #s1 has the 1st number now
    lla a0, fmt_false
    call printf
loop:
    beq s0, t3, end_true
    sub s2, s2, s2
    lla a0, fmt
    addi a1, sp, 0
    call scanf
    ld s2, 0(sp)       #s2 has the 2nd number now
    rem t1, s1, t0      #t1 has reminder of 1st number
    rem t2, s2, t0      #t2 has reminder of 2nd number
    beqz t1, first_is_even  #if first is even check parity of 2nd
    #else if 1st is odd
    beq t2, t3, both_same     #if both odd same parity
    #if both different
    sub s1, s1, s1
    add s1, s1, s2
    addi s0, s0, -1
    j loop
first_is_even:
    beqz t2, both_same  #if both even then print false and exit
    #else
    sub s1, s1, s1
    add s1, s1, s2   #if not then 2nd number becomes first now.
    addi s0, s0, -1     #number of times to check reduces by 1
    j loop      #go back to loop
both_same:
    lla a0, fmt_false
    call printf
    j exit
end_true:
    lla a0, fmt_true
    call printf
    j exit
exit:
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    addi sp, sp, 64
    ret
