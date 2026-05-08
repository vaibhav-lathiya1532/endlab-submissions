.data
infmt: .asciz "%d"
outfmt: .asciz "%d "
newline: .asciz "\n"

matrix: .space 4000
N: .word 0

.text
.globl main

main:
    la a0,infmt
    la a1,N 
    call scanf

    lw s1,N  #s1=N
    la s0,matrix   #s0=matrix base

    li s2,0 #i=0

readi:
    bge s2,s1,readdone
    li s3,0 #j=0

readj:
    bge s3,s1,nexti

    #A[i][j]   (i*N+j)*4
    mul s4,s2,s1
    add s4,s4,s3
    slli s4,s4,2
    add s4,s0,s4 

    la a0,infmt
    mv a1,s4
    call scanf

    addi s3,s3,1  #j=j+1
    j readj

nexti:
    addi s2,s2,1
    j readi

readdone:
    li s2,0

transi:
    bge s2,s1,transdone
    addi s3,s2,1

transj:
    bge s3,s1,transnexti

    #A[i][j]
    mul s4,s2,s1
    add s4,s4,s3
    slli s4,s4,2
    add s4,s0,s4 

    #A[j][i]
    mul s5,s3,s1
    add s5,s5,s2
    slli s5,s5,2
    add s5,s0,s5

    lw s6,0(s4)
    lw s7,0(s5)
    sw s7,0(s4)
    sw s6,0(s5)

    addi s3,s3,1
    j transj

transnexti:
    addi s2,s2,1
    j transi

transdone:
    li s2,0

revi:
    bge s2,s1,revdone
    li s3,0

revj:
    srli s8,s1,1 #N/2
    bge s3,s8,revnexti

    #A[i][j]
    mul s4,s2,s1
    add s4,s4,s3
    slli s4,s4,2
    add s4,s0,s4 

    #A[i][N-1-j]
    addi s9,s1,-1
    sub s9,s9,s3
    mul s5,s2,s1
    add s5,s5,s9
    slli s5,s5,2
    add s5,s0,s5

    lw s6,0(s4)
    lw s7,0(s5)
    sw s7,0(s4)
    sw s6,0(s5)

    addi s3,s3,1
    j revj

revnexti:
    addi s2,s2,1
    j revi

revdone:
    li s2,0

printi:
    bge s2,s1,end
    li s3,0

printj:
    bge s3,s1,printnewline

    mul s4,s2,s1
    add s4,s4,s3
    slli s4,s4,2
    add s4,s0,s4 

    lw a1,0(s4)
    la a0,outfmt
    call printf

    addi s3,s3,1
    j printj

printnewline:
    la a0,newline
    call printf

    addi s2,s2,1
    j printi

end:
    li a0,0
    ret









