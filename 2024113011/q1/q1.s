.section .rodata
FMTIN: .string "%d"
FMTOUT: .string "%s"
TRUE: .string "TRUE"    #ask for new line
FALSE: .string "FALSE"

.section .text
.globl main
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)           #n
    sd s1, 40(sp)           #store base address
    sd s2, 32(sp)           #element fetcher
    sd s3, 24(sp)           #prev ele parity
    sd s4, 16(sp)           
    j input_n
input_n:
    addi a1, sp, 0
    la a0, FMTIN
    #call scanf now
    call scanf
    #store input
    lw s0, 0(sp)
    j memalloc
memalloc:
    slli t0, s0, 4          #N*4 for space
    mv a0, t0
    call malloc
    #allocated memory
    mv s1, a0               #store the memory address now in s1
    j init_input

init_input:
    addi a1, s1, 0
    la a0, FMTIN
    #call scanf now
    call scanf
    #store input 1
    lw s2, 0(s1)
    andi s3, s2, 1          #parity of first int
    li t1, 1                #index iterator 
    j input_arr

input_arr:
    beq t1, s0, input_done          #i == N
    slli t2, t1, 2                  #i*4
    add t3, t2, s1                  #address = i*4 + base
    la a0, FMTIN
    addi a1, t3, 0                  #curr element address
    call scanf
    lw s2, 0(t3)                    #get that element
    #get parity and compare once
    andi t4, s2, 1                  #got current element parity
    beq t4, s3, SAME_PARITY         
    mv s3, t4                       #update parity
    addi t1, t1, 1                  #i++
    j input_arr
input_done:
    la a0, FMTOUT
    la a1, TRUE
    call printf
    j restore
SAME_PARITY:
    la a0, FMTOUT
    la a1, FALSE
    call printf
    j restore
restore:
    ld ra, 56(sp)
    ld s0, 48(sp)           #n
    ld s1, 40(sp)           #store base address
    ld s2, 32(sp)           #element fetcher
    ld s3, 24(sp)           #prev ele parity
    ld s4, 16(sp)
    addi sp, sp, 64
    mv a0, x0
    ret