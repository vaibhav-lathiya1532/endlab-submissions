.section .rodata
    input_str: .string "%lld %lld"
    output_str: .string "%lld %lld\n"
.section .text

.globl main
.extern printf
.extern scanf

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)
    sd s3, 40(sp)

    lla a0, input_str
    addi a1, sp, 0
    addi a2, sp, 8
    call scanf
    ld s0, 0(sp)
    ld s1, 8(sp)


    bge s0, s1, interchange
    j initialize

interchange:
    mv t0, s0
    mv s0, s1
    mv s1, t0

initialize:
    mv s2, s0
    mv s3, s1

gcd:
    beq s2, x0, lcm     #s3=gcd
    rem t0, s3, s2
    mv s3, s2
    mv s2, t0
    j gcd

lcm:
    li s2, 1
    div t0, s0, s3
    div t1, s1, s3
    mul s2, t0, t1
    mul s2, s2, s3      #s2=lcm
    
end:
    lla a0, output_str
    mv a1, s3
    mv a2, s2
    call printf

    ld ra, 56(sp)
    ld s0, 16(sp)
    ld s1, 24(sp)
    ld s2, 32(sp)
    ld s3, 40(sp)
    addi sp, sp, 64

    li a0, 0
    ret
