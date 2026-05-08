.section .rodata
fmt1:
.string "%lld"
fmt2:
.string "%lld\n"
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
     sd s2, 16(sp)

     lla a0, fmt1
     addi a1, sp,16
     call scanf
     ld s0, 16(sp)

     mv t0,s0;
     addi t1, x0, 0
     addi t2, x0, 10
     addi t4, x0, 0
     addi s2, x0, 0

count_digits:
     
      beqz t0, start_loop
      div t0, t0, t2
      addi t1, t1, 1

      j count_digits 

start_loop:
      
     mv t0, s0
     mv s1, t1

outer_loop:

     beqz t0, end_loop

     rem t3, t0, t2
     div t0, t0, t2

     mv t4, s1
     addi t5, x0, 1

inner_loop:

     beqz t4, inner_exit

     mul t5, t5, t3
     addi t4, t4, -1

     j inner_loop

inner_exit:
     
     add s2, s2, t5
     addi s1, s1, -1      

     j outer_loop

end_loop:     

     add t0, x0, s0

     beq t0, s2 , end_true

end_false:

     lla a0, fmt_false
     call printf
     j end

end_true:

     lla a0, fmt_true
     call printf
     
end:     
     ld ra, 40(sp)
     ld s0, 32(sp)
     ld s1, 24(sp)
     ld s2, 16(sp)
     addi sp, sp , 48

     li a0, 0
     ret


