.section .rodata
fmt: 
    .string "%lld"
fmt2:
    .string "%lld "
fmt3:
    .string "\n"
debug:
    .string "done till here"

.globl main
.section .text

main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    sd s3, 24(sp)
    sd s4, 16(sp)
    sd s5, 8(sp)

    lla a0, fmt
    mv a1, sp
    call scanf
    ld s2, 0(sp)    # n
    mul s1, s2, s2

    slli a0, s1, 3
    call malloc
    mv s0, a0

    li s3, 0     # i
    li s4, 0     # j
    li s5, 0

# --------------TAKE INPUT OF THE MATRIX--------------

inputRow:

    la a0, debug
    call printf

    la a0, fmt2
    mv a1, s3
    call printf

    la a0, fmt2
    mv a1, s2
    call printf
    
    bge s3, s2, inputComplete

    li s4, 0
    j inputColumn
    
inputColumn:
    bge s4, s2, rowInputDone
    
    mv t0, s3               # t0 = i
    mul t0, t0, s2          # t0 = i*n
    add t0, t0, s4          # t0 = i*n + j
    slli t0, t0, 3          # t0 = (i*n + j)*8
    add t0, t0, s0          # final address
    
    lla a0, fmt
    mv a1, t0
    call scanf              # take the input

    addi s4, s4, 1
    j inputColumn

rowInputDone:
    addi s3, s3, 1
    j inputRow

inputComplete:
    li s3, 0
    li s4, 0
    j transRow

# --------------TAKE TRANSPOSE OF THE MATRIX--------------

transRow:
    bge s3, s2, transDone
    mv s4, s3

    j transColumn

transColumn:
    bge s4, s2, transRowDone

    mv t0, s3               # t0 = i
    mul t0, t0, s2          # t0 = i*n
    add t0, t0, s4          # t0 = i*n + j
    slli t0, t0, 3          # t0 = (i*n + j)*8
    add t0, t0, s0          # final address (i, j)

    mv t1, s4               # t1 = j
    mul t1, t1, s2          # t1 = j*n
    add t1, t1, s3          # t1 = j*n + i
    slli t1, t1, 3          # t1 = (j*n + i)*8
    add t1, t1, s0          # final address (j, i)

    sd t2, 0(t0)
    sd t3, 0(t1)
    ld t3, 0(t0)
    ld t2, 0(t1)

    addi s4, s4, 1
    j transColumn
    
transRowDone:
    addi s3, s3, 1
    j transRow

transDone:
    li s3, 0
    li s4, 0
    j mirrorRows

# --------------MIRROR ALL THE ROWS--------------

mirrorRows:
    bge s3, s2, mirrorDone
    li s4, 0
    j mirrorColumns

mirrorColumns:
    add t0, s4, s4
    bge t0, s0, mirrorRowDone

    mv t1, s3               # t1 = i
    mul t1, t1, s2          # t1 = i*n
    add t1, t1, s4          # t1 = i*n + j
    slli t1, t1, 3          # t1 = (i*n + i)*8
    add t1, t1, s0          # final address (i, j)

    mv t2, s3               # t2 = i
    mul t2, t2, s2          # t2 = i*n  
    add t2, t2, s2          # t2 = i*n + n
    addi t2, t2, -1         # t2 = i*n + n - 1
    sub t2, t2, s4          # t2 = i*n + n - 1 - j
    slli t2, t2, 3          # t2 = (i*n + (n - 1 - j))*8
    add t2, t2, s0          # final address (i, n - 1 - j)

    sd t3, 0(t1)
    sd t4, 0(t2)
    ld t4, 0(t1)
    ld t3, 0(t2)

    addi s4, s4, 1
    j mirrorColumns

mirrorRowDone:
    addi s3, s3, 1
    j mirrorColumns

mirrorDone:
    li s3, 0
    li s4, 0
    j outputRow

# --------------PRINT THE FINAL MATRIX--------------

outputRow:
    bge s3, s2, outputDone
    li s4, 0
    j outputColumn

outputColumn:
    bge s4, s2, rowOutputDone
    
    mv t0, s3               # t0 = i
    mul t0, t0, s2          # t0 = i*n
    add t0, t0, s4          # t0 = i*n + j
    slli t0, t0, 3          # t0 = (i*n + j)*8
    add t0, t0, s0          # final address
    
    lla a0, fmt2
    mv a1, t0
    call printf              # print the value

    addi s4, s4, 1
    j outputColumn

rowOutputDone:

    lla a0, fmt3
    call printf

    addi s3, s3, 1
    j outputRow

outputDone:
    addi sp, sp, 64
    ld ra, 56(sp)
    ld s0, 48(sp)
    ld s1, 40(sp)
    ld s2, 32(sp)
    ld s3, 24(sp)
    ld s4, 16(sp)
    ld s5, 8(sp)
    li a0, 0
    ret
