.data
fmt: .asciz " %lld"
fmt_out: .asciz "%lld \n"
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
    li s4, 100
loop_beginning: 
    beq s2, s4, not_happy
    li t1, 0 
    j inner_loop
inner_loop: 
    # s1 has the number, calculate sum of square of digits in t0, load it into s1 then jump basically 
    beq s1, x0, loop_end 
    li t4, 10 
    rem t2, s1, t4
    mul t2, t2, t2 
    add t1, t1, t2 
    div s1, s1, t4
    
    j inner_loop 

loop_end:
    mv s1, t1
    mv a1, s1   
    la a0, fmt_out 
    li t1, 1 
    beq s1, t1, happy 

    beq s1, x0, not_happy
    addi s2, s2, 1 
    j loop_beginning 

not_happy: 
    addi a1, x0, 0
    la a0, fmt_out
    call printf 
    j done 
happy: 
    addi a1, x0, 1
    la a0, fmt_out 
    call printf 
    j done 
done: 
    ld ra,0(sp)
    addi sp, sp, 120
    
    