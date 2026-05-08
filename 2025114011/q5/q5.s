    .data
fmt_in:     .asciz  "%d"
fmt_out:    .asciz  "%d"
input:      .word   0
    .text
    .global main
    .extern printf
    .extern scanf
    .extern malloc

main:
    addi sp,sp,-64
    sd   ra,0(sp)
    sd  s0,8(sp)    #adress
    sd  s1,16(sp)   #i
    sd  s2,24(sp)   #j
    sd  s3,32(sp)   
    sd  s4,40(sp)   #n,input

    la  a0,fmt_in
    la  a1,input
    call   scanf

    lw  t0,input
    mv  s0,t0

    #malloc
    mul t0,t0,t0
    slli    t0,t0,3
    la  a0,t0
    call    malloc

    mv  s0,a0
    mv  t2,s4
    li  s1,0

take_input:
    li  s2,0
    bgt s1,s4,input_done

input_loop:
    mul t0,s1,s4
    add t0,t0,s2
    slli    t0,t0,3
    add     t0,t0,s0
    la  a0,fmt_in
    add    a1,a1,t0
    call scanf
    addi    s2,s2,1
    beq s2,s4,last_element
    j   input_loop

last_element:
    bgt s2,s4,take_nextrow
    mul t0,s1,s4
    add t0,t0,s2
    slli    t0,t0,3
    add     t0,t0,s0
    la  a0,fmt_in
    add  a1,a1,t0
    call scanf

    j take_nextrow

take_nextrow:
    addi s1,s1,1
    j take_input

input_done:
li  s1,0

take_output:
    li  s2,0
    bgt s0,s4,output_done
output_loop:
    bgt s2,s4,last_elemeneta
    sub t0,s4,s2
    mul t0,t0,s4
    add t0,t0,s1
    slli    t0,t0,3
    add     t0,t0,s0
    la  a0,fmt_out
    add    a1,a1,t0
    call    scanf
    addi    s2,s2,1
    j      output_loop
last_elemeneta:
    bgt s2,s4,out_nextrow
    sub t0,s4,s2
    mul t0,t0,s4
    add t0,t0,s1
    slli    t0,t0,3
    add     t0,t0,s0
    la  a0,fmt_out
    add    a1,a1,t0
    call    scanf
    j   out_nextrow
out_nextrow:
    addi    s1,s1,1
    j   take_output

output_done:
    ld  ra,0(sp)
    addi    sp,sp,64
    li  a0,0
    ret
