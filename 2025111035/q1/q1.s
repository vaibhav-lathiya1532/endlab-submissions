.global main
.data
int: .string "%lld"
tru: .string "TRUE"
fls: .string "FALSE"

.text
main:

addi sp, sp, -16
sd ra, 0(sp)

addi sp, sp, -16
addi a1, sp, 0
la a0, int
call scanf
ld s0, 0(sp)
addi sp, sp, 16


#s0 has no. of elements

addi sp, sp, -16
addi a1, sp, 0
la a0, int
call scanf
ld t0, 0(sp)
addi sp, sp, 16

addi s0, s0, -1

#t0 has the first no. well keep mode tracked by s1 , if s1 has 1 , current is odd , next should be even , and so on

li t1, 2
rem s1, t0, t1

#s1 contains remqainder

scan:

    beqz s0, true_l
    addi sp, sp, -16
    addi a1, sp, 0
    la a0, int
    call scanf
    ld t0, 0(sp)
    addi sp, sp, 16
    addi s0, s0, -1

    j check

check:
    li t1, 2
    rem t2, t0, t1
    #if its the same as s1 , thye print FALSE
    beq s1, t2, false_l

    addi s1, t2, 0
    #update remainder

    j scan

false_l:

    #first scan away all the elements
    inloop:
    beqz s0, prnt_false
    addi sp, sp, -16
    addi a1, sp, 0
    la a0, int
    call scanf
    ld t0, 0(sp)
    addi sp, sp, 16
    addi s0, s0, -1
    j inloop

    prnt_false:



    la a0, fls
    call printf
    j last
    
true_l:
    la a0, tru
    call printf
    j last

last:
    ld ra, 0(sp)
    addi sp, sp, 16
    ret




