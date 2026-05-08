.section .rodata
fmt1:
.string "%lld"
fmt2:
.string "%lld\n"
fmt3:
.string "%lld"
fmt_true:
.string "TRUE\n"
fmt_false:
.string "FALSE\n"

.section .text

.globl main

main:

     addi sp, sp , -48       
     sd ra, 40(sp)          
     sd s0, 32(sp)
     sd s1, 24(sp)

     lla a0, fmt2
     addi a1, sp,16
     call scanf
     ld s0, 16(sp)

     addi s3, x0,1

     lla a0, fmt3
     addi a1, sp, 8
     call scanf
     ld s1, 8(sp)

     addi s4, x0, 2
     addi s5, x0, 1
     addi s2, x0, 0

     rem t3, s1, s4

     beq s0, s5, end_false

     beq t3, s5,inner_odd

inner_even:     

     bge s3, s0, end_true

     addi s3, s3, 1

     lla a0, fmt3
     addi a1, sp, 8
     call scanf
     ld s1, 8(sp)

     rem t4, s1, s4
     beq t4, s5, inner_odd

     j end_false
     
inner_odd:     

     bge s3, s0, end_true

     addi s3, s3, 1

     lla a0, fmt3
     addi a1, sp, 8
     call scanf
     ld s1, 8(sp)

     rem t2, s1, s4
     beq t2, s2, inner_even

     j end_false     

end_false:

     lla a0, fmt_false
     call printf
     j end

end_true:

     lla a0, fmt_true
     mv a1, s1
     call printf

end:     

     ld ra, 40(sp)
     ld s0, 32(sp)
     ld s1, 24(sp)
     ld s2, 16(sp)
     addi sp, sp , 48

     li a0, 0
     ret

    