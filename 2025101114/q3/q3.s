.section .rodata
fmt: .string "%d"
fmt2: .string "%lld\n"

.section .text
.globl main

main:
    addi sp, sp, -40
    sd ra, 0(sp)
    sd s0, 8(sp)   #n
    sd s1, 16(sp)  #num
    sd s2, 24(sp)  #sum
    sd s3, 32(sp)  

    addi a1, sp, 8
    la a0, fmt
    call scanf
    lw s0, 8(sp)

    li s2, 0
  
read:
    ble s0, x0, done_read

    addi a1, sp, 16
    la a0, fmt
    call scanf
    lw s1, 16(sp)
    addi s3, s1, -1
    j check
    
check:
    li t0, 1
    beq s3, t0, prime
    rem t0, s1, s3
    beq t0, x0, notprime
    addi s3, s3, -1
    j check

notprime:
    addi s0, s0, -1
    j read
prime:
    add s2, s2, s1
    addi s0, s0, -1
    j read

done_read:
    mv a1, s2
    la a0, fmt2
    call printf
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    ld s2, 24(sp)
    ld s3, 32(sp)
    addi sp, sp, 40
    li a0, 0
    ret



