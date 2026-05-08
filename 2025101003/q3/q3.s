.section .rodata

fmt: .string "%lld"

.globl main
.section .text

main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s1, 16(sp)
    sd s2, 8(sp)

    la a0, fmt
    addi a1, sp, 0
    call scanf
    ld s1, 0(sp)            #has number of numbers
    li t0,0                 #store sum here
    li s2,5000              #check prime % till here


read_no:
    beq s1,x0,end #all nos done
    la a0, fmt
    addi a1, sp, 0
    call scanf
    ld t1, 0(sp)        #num to check for prime
    addi s1, s1, -1

check_prime:
    li t2, 2
    beq t2,t1,prime
    rem t3,t1,t2
    beq t3,x0,read_no
    
    li t2,3
    beq t2,t1,prime
    rem t3,t1,t2
    beq t3,x0,read_no

loop:
    addi t2,t2,2
    bge t2,t1,prime
    bge t2,s2,prime
    rem t3,t1,t2
    beq t3,x0,read_no
    j loop

prime:
    add t0, t0, t1
    j read_no

end:

    la a0,fmt
    addi a1,t0,0
    call printf

    ld ra, 24(sp)
    ld s1, 16(sp)
    addi sp, sp, 32
    ret

