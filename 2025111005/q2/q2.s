.data
infmt: .asciz "%d %d"
outfmt: .asciz "%d %d\n"


M: .word 0
N: .word 0

.text
.globl main

main:
    la a0,infmt
    la a1,M 
    la a2,N 
    call scanf

    lw s1,M 
    lw s2,N
    
    add s3,x0,s1 
    add s4,x0,s2 

gcd:
    beq s4,x0,gcddone
    add s3,x0,s4 #a=b
    rem s4,s3,s4 #b=b%a

    j gcd
    

gcddone:
    add s8,x0,s3
    add s3,x0,s1 #a
    add s4,x0,s2 #b

/*
printd:
    li a2,0
    lw a1,0(s1)
    la a0,outfmt 
*/

greater:
    bge s3,s4,ag
    blt s3,s4,bg
    #s5 is the greater of both values

lcm:
    rem s6,s5,s3
    rem s7,s5,s4
    beq s6,s7,maybelcm
    addi s5,s5,1
    j lcm

ag:
    add s5,x0,s3
    j lcm

bg:
    add s5,x0,s4
    j lcm

maybelcm:
    beq s6,x0,print
    j lcm

print:
    lw a2,0(s5)
    lw a1,0(s8)
    la a0,outfmt
    call print

end:
    li a0,0
    ret
     


