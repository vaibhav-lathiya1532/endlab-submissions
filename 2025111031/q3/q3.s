.section .rodata
input_string:
    .asciz "%lld"
output_string:
    .asciz "%lld\n"
.section .data
num:
    .quad 0
.section .bss
array:
    .space 1000000


.section .text

.globl main

input:
    addi sp, sp, -48
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd ra, 0(sp)
    lla a0, input_string
    lla a1, num
    call scanf
    li s4, 0                                #running sum
    lla s1, num
    ld s1, 0(s1)                            #number of inputs
    li s2, 0                                #counter



input_loop:
    bge s2, s1, input_over
    slli s3, s2, 3
    lla a1, array
    add s3, a1, s3
    mv a1, s3
    lla a0, input_string
    call scanf
    ld s3, 0(s3)
    add s4, s4, s3
    addi s2, s2, 1
    j input_loop


input_over:
    mv a0, s4
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld ra, 0(sp)
    addi sp, sp, 48
    ret


#takes a0 as the total sum and derives the rest
find_target:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd t1, 56(sp)

    lla s1, num
    ld s1, 0(s1)                    #number of elements
    mv s2, a0                       #total sum
    li s3, 0                        #left sum
    li s4, 0                        #counter


loop:
    bge s4, s1, fail
    slli s5, s4, 3
    lla a1, array
    add s5, a1, s5                  # go to the appropriate address
    ld s5, 0(s5)                    #get value
    mv s6, s2                       #total sum
    sub s6, s6, s5                  #subtract current elements
    sub s6, s6, s3                  #subtract left sum
    beq s6, s3, success             #if equal success
    add s3, s5, s3                  # add curretn node to left sum
    addi s4, s4, 1
    j loop

success:
    mv a1, s4
    mv s1, s4
    lla a0, output_string
    call printf
    j last 
fail:
    li a1, -1
    mv s1, a1
    lla a0, output_string
    call printf
    j last

last:
    mv a0, s1
    ld ra, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld t1, 56(sp)
    addi sp, sp, 64
    ret







main:
    addi sp, sp, -8
    sd ra, 0(sp)
    call input
    call find_target
    ld ra, 0(sp)
    ret








