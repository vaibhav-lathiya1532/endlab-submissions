
.bss
    inbuf: .space 128
.data
    fmt_in:  .string "%s"
    fmt_out: .string "%ld\n"
.text
.global main
main:
    la   a0,fmt_in
    la   a1, inbuf
    call scanf

    la   s0,inbuf          

eval_loop:
    lb   t0, 0(s0)
    beq t0, zero, eval_done

    li   t1,'0'
    blt  t0, t1, do_op
    li   t1,'9'
    bgt  t0, t1, do_op
    li   t1,'0'
    sub  t0, t0, t1
    addi sp,sp, -8
    sd   t0, 0(sp)
    j    eval_next

do_op:
    ld   s2, 0(sp)         
    addi sp,sp, 8
    ld   s1, 0(sp)   
    addi sp,sp, 8

    li   t1,'+'
    beq  t0,t1, op_add
    li   t1,'-'
    beq  t0, t1, op_sub
    mul  s1,s1, s2
    j    op_push

op_add:
    add  s1,s1,s2
    j    op_push

op_sub:
    sub  s1,s1,s2

op_push:
    addi sp, sp, -8
    sd   s1, 0(sp)

eval_next:
    addi s0,s0, 1
    j    eval_loop

eval_done:
    ld   s1, 0(sp)         
    addi sp, sp, 8

    la   a0,fmt_out
    mv   a1, s1
    call printf
    call exit
