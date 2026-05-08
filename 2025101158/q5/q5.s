.section .rodata
fmtfirst: .string "%lld "
output: .string "%lld "
newline: .string "\n"

.section .text

.global main

main:
    addi sp, sp, -256
    sd ra, 248(sp)
    sd s0, 240(sp)#n
    sd s1, 232(sp)#base address
    sd s2, 224(sp)#count len
    sd s3, 216(sp)#n*n
    sd s4, 208(sp)
    sd s5, 200(sp)




    
    lla a0, fmtfirst
    addi a1, sp, 16
    call scanf
    ld s0, 16(sp)

    mul t1, s0, s0
    mv s3, t1
    slli t1, t1, 3
    mv a0, t1   
    call malloc
    mv s1, a0  #base address
    li s2, 1 #count len




scanloop:
    beq s2, s3, init
    div t2 , s2, s0
    rem t3, s2, s0
    sub t3, s0, t3
    
    addi t3, t3,-1
    addi t4, t2, -1
    mul t2, t4, s0 # rowoffset
    slli t2, t2, 3
    slli t3, t3, 3 #col offset
    add t1, t3,t2 #offfset
    add t1, t1, s1 #t1=base+offset
    lla a0, fmtfirst
    mv a1, t1
    
    call scanf
    addi s2,s2,1
    j scanloop

init:
li s5, 1

logic:
    beq s5,s3, exit
    rem t2, s5, s0
  #  beq t2, x0, new
sec:   
    slli t1, s5, 3
    add t1, t1, s1
    lla a0, output
    mv a1, t1
    call printf
    addi s5, s5, 1
    j logic


# new:
#     la a0, newline
#   call printf
#    j logic

exit:
    
    ld ra, 248(sp)
    ld s0, 240(sp)#n
    ld s1, 232(sp)#base address
    ld s2, 224(sp)#count len
    ld s3, 216(sp)#n*n
    ld s4, 208(sp)
    ld s5, 200(sp)
    addi sp, sp, 256
    ret


