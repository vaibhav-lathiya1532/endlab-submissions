.section .data
    fmt_in: .string "%lld"
    fmt_otn: .string "%lld "
    fmt_nl: .string "\n"
    fmt_ch: .string "%lld"

.text
.global main

main:
    addi sp,sp,-80
    sd ra,0(sp)
    sd s0,8(sp)    
    sd s1,16(sp)
    sd s2,24(sp)            # s1-s0
    sd s3,32(sp)            #25 
    sd s4,40(sp)            #10
    sd s5,48(sp)            #5
    sd s6,56(sp)            #1

    lla a0,fmt_in
    add a1,sp,64
    call scanf
    ld s0,64(sp)

    lla a0,fmt_in
    add a1,sp,64
    call scanf
    ld s1,64(sp)

    sub s2,s1,s0
    li s3,0
    li s4,0
    li s5,0
    li s6,0

    ttfloop:
        li t0,25
        blt s2,t0,tensloop

        addi s2,s2,-25
        addi s3,s3,1

        beq x0,x0,ttfloop

    tensloop:
        li t0,10
        blt s2,t0,fivsloop

        addi s2,s2,-10
        addi s4,s4,1

        beq x0,x0,tensloop

    fivsloop:
        li t0,5
        blt s2,t0,ones

        addi s2,s2,-5
        addi s5,s5,1

        beq x0,x0,fivsloop

    ones:
        add s6,s2,x0

        beq x0,x0,print

    print:
        lla a0,fmt_otn
        add a1,s3,x0
        call printf

        lla a0,fmt_otn
        add a1,s4,x0
        call printf

        lla a0,fmt_otn
        add a1,s5,x0
        call printf

        lla a0,fmt_otn
        add a1,s6,x0
        call printf

        lla a0,fmt_nl
        call printf

        beq x0,x0,end

    end: 
        ld ra,0(sp)
        ld s0,8(sp)    
        ld s1,16(sp)
        ld s2,24(sp)           
        ld s3,32(sp)            
        ld s4,40(sp)            
        ld s5,48(sp)            
        ld s6,56(sp)            
        addi sp,sp,80

        add a0,x0,x0
        ret

