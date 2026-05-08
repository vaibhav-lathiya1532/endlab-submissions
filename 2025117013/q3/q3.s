.data

inp_x : .string "%d"
inpnam : .string


.Text
.globl main

main:   
    addi sp, sp, -48
    la ra, sp(40)
    sd x1, sp(32)
    sd x2, sp(24)
    sd x3, sp(16)
    sd x4, sp(8)

    la t0, inp_x
    la t1, inpnam
    call scanf
    mv t1, t0

loop_a:
    
    addi t1, t1, -1
    ble t1, 0, done
    
    



