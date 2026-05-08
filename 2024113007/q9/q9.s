.section .rodata
fmt_in: .asciz "%lld"
fmt_out: .asciz "%lld\n"

.section .text
.global main
.extern scanf
.extern printf

main:
     addi sp,sp,-48
     sd   ra,40(sp)
     sd    s0,32(sp)
     sd    s1,24(sp)
     sd    s2 ,16(sp)
     sd    s3 ,8(sp)
     sd    s4 ,0(sp)

     la a0,fmt_in
     addi a1,sp,0
     call scanf
     ld s1,0(sp)
     li s2,0
     li s4,0

     external_loop:
                   li t0,100
                   li s3,0
                   bge s2,t0,pr
                       mv t1,s1

                    internal_loop:
                                  beqz t1,internal_done
                                  li t2,10
                                  rem t3,t1,t2
                                  mul t4,t3,t3
                                  add  s3,s3,t4
                                  div t1,t1,t2
                                 j internal_loop
         
                                 internal_done:
                                               li t5,1
                                               beq s3,t5,happy
                                               mv s1,s3
                                               add s2,s2,1
                                               j external_loop    
                                               
                                              pr:
                                              la a0,fmt_out
                                                 mv a1,s4
                                                 call printf
                                                 j done


                                               happy:
                                                     li s4,1
                                                     j pr

                                               done:
                                                    li a0,0
                                                    ld ra,40(sp)
                                                    ld s0,32(sp)
                                                    ld s1,24(sp)
                                                    ld s2,16(sp)
                                                    ld s3,8(sp)
                                                    ld s4,0(sp)
                                                    addi sp,sp,48
                                                    ret
      

  
     