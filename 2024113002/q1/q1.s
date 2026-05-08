.data
    fmt_n: .asciz "%d"
    fmt_in: .asciz "%d "
    fmt_true: .asciz "TRUE\n"
    fmt_false: .asciz "FALSE\n"

    n: .quad 0

.text
.globl main
.extern scanf
.extern printf
.extern malloc

main:

    la a0, fmt_n
    ld a1, n

    call scanf

    ld t0, n #t0 = n

    slli t1, t0, 3 #allocating n*8bytes space
    mv a0, t1
    call malloc

    mv s1, t1 #s1 = base address of array

    li t1, 0 # i = 0

read_i:

    beqz t0, result
    bgt t1, t0, parity_check
    mul t1, t1, s1
    slli t2, t1, 3
    add t3, s1, t2 #finding address of a[i]

    la a0, fmt_in
    call scanf

    addi t1, t1, 1 #i++
    j read_i

parity_check: 

    li t1, 0 # i = 0
    li t4, 2
   #p is even if number iseven, p is odd if no is odd 


parity_loop:

    bgt t1, t0, success

    mul t1, t1, s1
    slli t2, t1, 3
    add t3, s1, t2 #t3 = a[i]


even_check:

    ld t4, t3
    li t5, 2
    rem t4, t4, t5

    beqz t4,next_parity_odd

    ld t6,t7
    rem t6, t6, t5
    beqz t6, odd_check #prev number was even so this will check for odd

    bnez t6, end #prev no was odd this is also odd 


next_parity_odd:

    addi t1, t1, 1
    li t5, 2
    mul t4, t4, t5

    j parity_loop

odd_check:

    ld t4, t3
    li t5, 2
    rem t4, t4, t5

    bnez t4, next_parity_even

    ld t6,t7
    rem t6, t6, t5
    bnez t6,even_check #prev number was odd so this will check for even

    beqz t6, end #prev no was even this is also even
    
next_parity_even:

    addi t1, t1, 1
    addi t4, t4, 1

    j parity_loop

success:

    la a0, fmt_true
    call printf

    li a0, 0
    ret

end:

    la a0, fmt_false
    call printf

    li a0, 0
    ret






    


    

