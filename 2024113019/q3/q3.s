.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld\n"

.section .text

.globl main


main:
    addi sp,sp,-64
    sd s0,56(sp) #N
    sd s1,48(sp) #mainarray pointer
    sd s2,40(sp) #ps1 pointer
    sd s3,32(sp)#ps2 pointer
    sd s4,24(sp) #genberal coiunter
    sd ra,8(sp)

    la a0,fmt_in
    addi a1,sp,0
    call scanf
    ld s0,0(sp)

    #malloc the main array
    slli a0,s0,3 # N*8
    call malloc
    mv s1,a0

    #malloc prefix sum arr 1
    slli a0,s0,3 # N*8
    call malloc
    mv s2,a0

    #malloc prefix sum arr 2
    slli a0,s0,3 # N*8
    call malloc
    mv s3,a0

    li s4,0



read_loop:
    beq s4,s0,read_done

    la a0,fmt_in

    slli t1,s4,3 #i*8
    add t1,t1,s1 #base + i*8

    mv a1,t1
    call scanf
    addi s4,s4,1
    j read_loop


read_done:
   
    li s4,0
    li t0,0


ps1_fill:
    beq s4,s0,ps1_done
    slli t1,s4,3 #i*8
    add t1,t1,s1 #base + i*8
    ld t4,0(t1)
    add t0,t0,t4

    slli t1,s4,3 #i*8
    add t1,t1,s2 #base + i*8
    sd t0,0(t1)
    addi s4,s4,1
    j ps1_fill

ps1_done:
    addi s4,s0,-1 #n-1

    li t0,0

ps2_fill:
    blt s4,x0,ps2_done
    slli t1,s4,3 #i*8
    add t1,t1,s1 #base + i*8
    ld t4,0(t1)
    add t0,t0,t4

    slli t1,s4,3 #i*8
    add t1,t1,s3 #base + i*8
    sd t0,0(t1)
    addi s4,s4,-1
    j ps2_fill

ps2_done:
    li s4,0


iterate_and_check:
    beq s4,s0,nothing
    slli t1,s4,3 #i*8
    add t1,t1,s2 #base + i*8

    slli t2,s4,3 #i*8
    add t2,t2,s3 #base + i*8
    
    ld t3,0(t1)
    ld t4,0(t2)
    beq t3,t4,found
    addi s4,s4,1
    j iterate_and_check

found:
    la a0,fmt_out
    mv a1,s4
    call printf
    mv a0,s1
    call free
    mv a0,s2
    call free
    mv a0,s3
    call free
    ld s0,56(sp) #N
    ld s1,48(sp) #mainarray pointer
    ld s2,40(sp) #ps1 pointer
    ld s3,32(sp)
    ld ra,8(sp)
    addi sp,sp,64

   
    li a0,0

    ret
nothing:
    la a0,fmt_out
    li a1,-1
    call printf
     mv a0,s1
    call free
    mv a0,s2
    call free
    mv a0,s3
    call free
    ld s0,56(sp) #N
    ld s1,48(sp) #mainarray pointer
    ld s2,40(sp) #ps1 pointer
    ld s3,32(sp)
    ld ra,8(sp)
    addi sp,sp,64
    li a0,0
    ret
