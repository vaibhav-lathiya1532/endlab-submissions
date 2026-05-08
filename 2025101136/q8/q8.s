.section .data
input: .string "%lld"
output: .string "%lld\n"

.section .text
.global main

#s0=n, s1= base_arr, s2=target
main:

    addi sp, sp, -40
    sd ra, 8(sp)
    sd s0, 16(sp)
    sd s1, 24(sp)
    sd s2, 32(sp)

    la a0, input
    addi a1,sp,0
    call scanf

    ld s0, 0(sp) #gives n

    slli t0, s0, 3 #as all are long long

    mv a0, t0
    call malloc

    mv s1, a0 #base arr

    li t0, 0 #i

    loop:
        bge t0, s0, loop_done

        slli t1, t0, 3
        add t1, t1, s1

        la a0, input
        addi a1, t1, 0
        call scanf

        addi t0, t0, 1
        j loop
    

    loop_done:

        la a0, input
        addi a1, sp, 0
        call scanf

        ld s2, 0(sp)  #target


    binary_search:

        li t0, 0 #low=t0
        addi t1, s0, -1 #high=t1 , mid=t2

        binary_search_loop:

            bgt t0, t1, binary_search_done

            add t2, t0, t1
            srli t2, t2, 1

            #low
            slli t3, t0, 3
            add t3, t3, s1
            ld t4, 0(t3)

            #high
            slli t3, t1, 3
            add t3, t3, s1
            ld t6, 0(t3)

            #mid
            slli t3, t2, 3
            add t3, t3, s1
            ld t5, 0(t3)

            beq t5, s2, binary_search_found

            ble t4, t5, binary_search_low
            
            binary_search_high:

                blt s2, t5, binary_search_find_low
                bgt s2, t6, binary_search_find_low

                binary_search_find_high:
                    addi t0, t2, 1 #low=mid+1
                    j binary_search_loop

                binary_search_find_low:
                    addi t1, t2, -1 #high=mid-1
                    j binary_search_loop
            
            binary_search_low:
                
                blt s2, t4, binary_search_find_high
                bgt s2, t5, binary_search_find_high

                j binary_search_find_low


        binary_search_done:

            la a0, output
            li a1, -1
            call printf

            ld ra, 8(sp)
            ld s0, 16(sp)
            ld s1, 24(sp)
            ld s2, 32(sp)
            addi sp, sp, 40

            li a0, 0
            ret
        
        binary_search_found:

            la a0, output
            mv a1, t2
            call printf

            ld ra, 8(sp)
            ld s0, 16(sp)
            ld s1, 24(sp)
            ld s2, 32(sp)
            addi sp, sp, 40

            li a0, 0
            ret








