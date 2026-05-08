.section .rodata

input:      .string "%d"
true_str:   .string "TRUE\n"
false_str:  .string "FALSE\n"


.section .text
.global main


main:
    addi sp, sp, -64
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    sd s2, 24(sp)
    sd s3, 32(sp)
    sd s4, 40(sp)


    la a0, input
    addi a1, sp, 48
    call scanf

    lw s0, 48(sp)
    mv s1, s0

    li s2, 0

count:
    beqz s1,count_done
    li t0, 10
    divu s1, s1, t0
    addi s2,s2,1
    j count

count_done:

    li s4, 1
    addi t0, s2, -1

pow10:
    beqz t0,pow10_done
    li t1, 10
    mul s4, s4, t1
    addi t0, t0, -1
    j pow10

pow10_done:
    
    mv s1, s0
    li s3, 0
    li t5, 1

loop:
    beqz s4, done_calc

    div t0, s1, s4
    rem s1, s1, s4

    mv t1, t0
    mv t2, t5
    li t3, 1

power:
    beqz t2, power_done
    mul t3, t3, t1
    addi t2, t2, -1
    j power

power_done:
    add s3, s3, t3

    li t0, 10
    div s4, s4,t0
    addi t5, t5, 1
    j loop

done_calc:
    bne s3, s0, not_disarium
    
    la a0, true_str
    call printf
    j end


not_disarium:
    la a0, false_str
    call printf

end:
    ld ra, 0(sp)
    addi sp, sp, 64
    ret

