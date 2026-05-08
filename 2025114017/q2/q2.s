.data
    input_fmt: .string "%lld"
    output_fmt: .string "%lld %lld\n"

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
    ld s0,0(t0) #s0 = num1

    la a0, input_fmt
    la a1,input_bf
    call scanf

    la t0, input_bf
    ld s1,0(t0) #s1 = num2

    bgt s1,s2, logic

    mv t1,s1
    addi s1,s2,0
    addi s2,t1,0

    #s0 now contains larger number
    #s1 now containers smaller number

logic:
    mul s9,s0,s1

    addi a0,s0,0
    addi a1,s1,0

    call gcd
    mv s7,a0
    j lcm

gcd:
    addi sp, sp, -16
    sd ra,8(sp)

    li t3,0
    beq a1,t3,base_case

    rem t4, a0,a1
    mv a0,a1
    mv a1,t4

    call gcd

    ld ra,8(sp)
    addi sp, sp, 16
    ret




base_case:
    ld ra,8(sp)
    addi sp, sp, 16
    ret

lcm:
    div s8,s9,s7

end:
    la a0, output_fmt
    addi a1,s7,0
    addi a2,s8,0

    call printf

    ld ra,8(sp)
    addi sp, sp, 16
    
    li a0,0
    ret
