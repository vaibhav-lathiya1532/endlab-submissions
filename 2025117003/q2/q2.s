.data
m: .dword 0
n: .dword 0
iformat: .string "%lld"
oformat: .string "%lld"

.text
.global main

main:
    addi sp,sp,-16
    sw ra,0(sp)

    la a0,iformat
    la a1,m
    call scanf

    la t1,m
    ld s0,0(t1)

    la a0,iformat
    la a1,n
    call scanf

    la t1,n
    ld s1,0(t1)

#s0 has m and s1 has n#
    bgt s0,s1,m_greater
    ld s6,0(s0)
    ld s5,0(s1)
# s6 has the value of smaller element#


m_greater:
    ld s6,0(s1)
    ld s5,0(s0)


gcd_cal:
    li s3,2 #loop incrementer#
    li s4,1 #gcd#
    add t4,s2,x0
    div t4,t4,s3
    loop:
        beq s3,t4,print_GCD
        rem t2,s0,s3
        rem t3,s1,s3
        add t2,t2,t3
        bne t2,x0,loop
        ld s4,0(s3)
        addi s3,s3,1
        j loop

setup_lcm:
    ld s2,0(s6)
    
lcm_cal:
    beq s2,s5,equal_lcm

s2_checker:    
    add s2,s2,s2
    bgt s5,s2,s2_checker
    blt s5,s2,s5_incrementer
    beq s2,s5,equal_lcm

s5_incrementer:
    add s5,s5,s5
    beq s2,s5,equal_lcm
    j s2_checker

print_GCD:
    la a0,oformat
    ld a1,0(s4)
    call printf
    ld ra,0(sp)
    addi sp,sp,16
    call exit

equal_lcm:
    la a0,oformat
    ld a1,0(s2)
    call printf
    ld ra,0(sp)
    addi sp,sp,16
    call exit