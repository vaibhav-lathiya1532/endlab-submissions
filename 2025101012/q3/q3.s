.data
fmt_in: .string "%d"
x: .word 0
fmt_out: .string "%d\n"
array: .space 4004

.text
.global main

main:
    addi sp , sp , -16
    sd ra , 8(sp)
    la a0 , fmt_in
    la a1 , x
    call scanf
    ld s0 , x
    li t1 , 0
    mv t2 , s0
    la s1 , array
    mv t3 , s1

loop:
    bge t2 , s0 , loop_2
    la a0 , fmt_in
    mv a1 , t3
    call scanf
    addi t2 , t2 , 1
    addi t3 , t3 , 4
    j loop

loop_2:


next:
    li t1 , 0
    mv t2 , s1
    mv t3 , s0

printvals:
    bge t1 , s0 , end
    ld t4 , 0(t2)
    la a0 , fmt_in
    mv a1, t4
    call printf
    addi t1 , t1 , 1
    addi t2 , t2 ,4
    j printvals

end:
    ld ra, 8(sp)
    addi sp , sp , 16
    ret