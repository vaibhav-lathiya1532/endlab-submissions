.section .data
    fmt_in: .string "%lld"
    fmt_t: .string "TRUE\n"
    fmt_f: .string "FALSE\n"

.text
.global main

main:
    addi sp,sp,-64
    sd ra,0(sp)
    sd s0,8(sp)     # n
    sd s1,16(sp)
    sd s2,24(sp)    #array address
    sd s3,32(sp)
    sd s4,40(sp)
    sd s5,48(sp)
    
    lla a0,fmt_in 
    addi a1,sp,56
    call scanf
    ld s0,56(sp)

    slli s1,s0,8
    mv a0,s1
    call malloc
    mv s2,a0

    addi s3,s2,0
    li s5,0
    sloop:
        ble s0,s5,sdone

        lla a0,fmt_in
        addi a1,sp,56
        call scanf
        ld t0,56(sp)
        sd t0,0(s3)

        addi s3,s3,8
        addi s5,s5,1

        beq x0,x0,sloop

    sdone:
        li t0,1
        beq t0,s0,p_f

        li t0,2
        ld t1,0(s2)
        rem t2,t1,t0

        li s3,0         # address of the ith element
        add s3,s2,x0
        li s4,0         #counter

        li t0,0
        beq t2,t0,f_even

        #here continues means first is odd 
        f_odd:
            li s5,1
            beq x0,x0,cloop

        f_even:
            li s5,0
            beq x0,x0,cloop


            cloop:
                ble s0,s4,p_t

                ld s1,0(s3)
                li t1,2

                rem t2,s1,t1
                beq t2,s5,nxtitr

                beq x0,x0,p_f

                nxtitr:
                    li t0,0
                    beq s5,t0,set1

                    set0:
                        li s5,0
                        addi s3,s3,8
                        addi s4,s4,1
                        beq x0,x0,cloop

                    set1:
                        li s5,1
                        addi s3,s3,8
                        addi s4,s4,1
                        beq x0,x0,cloop

            p_f:
                lla a0,fmt_f
                call printf
                beq x0,x0,end

            p_t:
                lla a0,fmt_t
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
        addi sp,sp,64
        add a0,x0,x0
        ret
