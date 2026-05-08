.section .rodata
fmt_in_n: .asciz "%lld"
fmt_in_val: .asciz "%lld"
fmt_out: .asciz "%lld\n"

.section .text
.global main
.extern scanf
.extern printf
.extern malloc
.extern free

main:
      addi sp,sp,-56
     sd   ra,48(sp)
     sd    s0,40(sp)
     sd    s1,32(sp)
     sd    s2 ,24(sp)
     sd    s3 ,16(sp)
     sd    s4 ,8(sp)
     sd   s5,  0(sp)
     la a0,fmt_in
     addi a1,sp,0
     call scanf
     ld s1,0(sp)
     slli a0,s1,3
     call malloc
     mv s2,a0
     li s3,0
    scan_loop:
             bge s3,s1,scan_done 
             mul t0,s3,s1
             slli t0,t0,3
             add t1,s2,t0
             la a0,fmt_in_val
             mv a1,t1
             call scanf
             addi s3,s3,1
             j scan_loop 
     scan_done:
               li s4,1
               addi s3,s1,-1

               main_loop:
                         mul t0,s4,s1
                         slli t0,t0,3
                         add t1,s2,t0
                         
                         ld 
                         mul t2,s1,s1
                         slli t2,t2,3
                         add t4,s2,t2
                         ld
                         mul t0,s4,s1
                         slli t0,t0,3
                         add t1,s2,t0

                            inner_loop:
                                
                         
