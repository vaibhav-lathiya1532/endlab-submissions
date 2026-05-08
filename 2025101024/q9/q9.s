.data
input_fmt: .asciz "%lld"
output_fmt: .asciz "%lld"
n: .space 8

.text
.global main

main:
    addi sp,sp,-48
    sd ra,40(sp)
    sd s0,32(sp)
    sd s1,24(sp)
    sd s2,16(sp)
    sd s3,8(sp)
    sd s4,0(sp)
#input
    la a0,input_fmt
    la a1,n
    call scanf
    ld t0,n
    ld s0,0(t0)

    li t0,1
    beq s0,t0,print_happy
    li s1,0
    li s4,100
    
outer_loop:
    bge s1,s4,not_happy
    mv s3,s0 #n
    li s2,0 #sum
inner_loop:
    li t2,0
    ble s3,t2, done_inner
    li t3,10
    rem t4,s3,t3
    mul t5,t4,t4
    add s2,s2,t5
    div s3,s3,t3
    j inner_loop
done_inner:
    mv s0,s2
    addi s1,s1,1
    li t0,1
    beq s0,t0,print_happy
    j outer_loop

print_happy:
    li t6,1
    mv a1,t6
    la a0,output_fmt
    call printf
    j done

not_happy:
    li t6,0
    mv a1,t6
    la a0,output_fmt
    call printf

done:
    ld ra,40(sp)
    ld s0,32(sp)
    ld s1,24(sp)
    ld s2,16(sp)
    ld s3,8(sp)
    ld s4,0(sp)
    addi sp,sp,48
    li a0,0
    ret

