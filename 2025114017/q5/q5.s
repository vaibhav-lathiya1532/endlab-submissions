.data
    input_fmt: .string "%lld"
    output_fmt: .string "%lld "
    nl: .string "\n"

.align 4

.bss
    input_bf: .space 32

.text
    .globl main

main:
    addi sp, sp, -16
    sd ra,8(sp)

    la a0, input_fmt
    la a1,input_bf
    call scanf

    la t0, input_bf
    ld s0,0(t0) #s0 = length

    mul a0, s0,s0
    slli a0,a0,3
    call malloc

    mv s7,a0 #s7 is the base address

    mul s10,s0,s0
    li s9,0

input:
    beq s9,s10,logic

    la a0, input_fmt
    la a1, input_bf
    call scanf

    la t0, input_bf
    ld t0,0(t0)   #t0 now stores the exact values that was inputed

    slli t3, s9, 3 #t3 = offset 
    add t3, t3, s7  #t3 = address 

    sd t0,0(t3)


    addi s9,s9,1
    j input    


logic:
    li s8,-1

transpose_outer:
    addi s8,s8,1
    beq s8,s0, reverse
    addi s9,s8,1

transpose_inner:
    beq s9,s0,transpose_outer

    mul t4,s8,s0
    add t4,t4,s9
    slli t4,t4,3
    add t4,t4,s7

    ld t5,0(t4)

    mul s2, s9, s0
    add s2,s2,s8
    slli s2,s2,3
    add s2,s2,s7

    ld s3,0(s2)

    sd s3,0(t4)
    sd t5,0(s2)

    addi s9,s9,1
    j transpose_inner

reverse:
    li s8,-1

reverse_outer:
    addi s8,s8,1
    beq s8,s0,print
    li s9,0

reverse_inner:
    addi t2,s0,0
    li t1,2
    div t2,t2,t1
    bge s9,t2,reverse_outer

    mul t4,s8,s0
    add t4,t4,s9
    slli t4,t4,3
    add t4,t4,s7

    ld t5,0(t4)

    mul s2,s8,s0
    add s2, s2,s0
    addi s2,s2,-1
    sub s2,s2,s9
    slli s2,s2,3
    add s2,s2,s7

    ld s3,0(s2)

    sd s3,0(t4)
    sd t5,0(s2)

    addi s9,s9,1
    j reverse_inner


print:
    li s8,-1

print_outer:
    addi s8,s8,1
    beq s8,s0,end
    li s9,0

print_inner:
    beq s9,s0,new_line

    
    mul t5,s8,s0
    add t5,t5,s9
    slli t5,t5,3
    add t5,t5,s7

    ld a1,0(t5)
    la a0, output_fmt
    call printf


    addi s9,s9,1
    j print_inner

new_line:
    la a0, nl
    call printf
    j print_outer

end:
    ld ra,8(sp)
    addi sp, sp, 16

    li a0,0
    ret

    