.global main
.data

fmt: .string "%lld"
space: .string  " "


.text

main:
#save ra
addi sp, sp, -16
sd ra, 0(sp)


#use s0 to track change to be dispensed


addi sp, sp, -16
addi a1, sp, 0

la a0, fmt

call scanf



ld t0, 0(sp)

addi sp, sp, 16
#t0 has price
#t1 has amout paid . cxahnge =t1-t0


#fmtut amout inserted


#
addi sp, sp, -16
addi a1, sp, 0

la a0, fmt

call scanf

ld t1, 0(sp)

addi sp, sp, 16
#



#change =t1-t0

sub s0, t1, t0
#s0 has the change


#keeping s1 track of how many coins of 25
#s2 track coins of 10
#s3 track coins of 5
#s4 track coins of 1
li s4, 0
li s3, 0
li s2, 0
li s1, 0

twentyfive:
    beq s0, zero, ten
    li t0, 25
    blt s0, t0, ten

    addi s0, s0, -25
    addi s1, s1, 1

    j twentyfive


ten:

    beq s0, zero, five
    li t0, 10
    blt s0, t0, five

    addi s0, s0, -10
    addi s2, s2, 1

    j ten

five:
    beq s0, zero, one
    li t0, 5
    blt s0, t0, one

    addi s0, s0, -5
    addi s3, s3, 1

    j five

one:
    beq s0, zero, print_loop
    li t0, 1
     

    addi s0, s0, -1
    addi s4, s4, 1

    j one

print_loop:

    la a0, fmt
    addi a1, s1, 0
    call printf

    la a0, space
    call printf

    la a0, fmt
    addi a1, s2, 0
    call printf

    la a0, space
    call printf

    la a0, fmt
    addi a1, s3, 0
    call printf

    la a0, space
    call printf

    la a0, fmt
    addi a1, s4, 0
    call printf

    la a0, space
    call printf



    ld ra , 0(sp)
    addi sp, sp, 16
    ret




