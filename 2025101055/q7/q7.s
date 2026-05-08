.section .data

input_fmt: .string "%lld"
output_true_fmt: .string "TRUE\n"
output_false_fmt: .string "FALSE\n"

n: .dword 0

.section .text

.globl main
main:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd s0, 8(sp)
    sd s1, 0(sp)

    la a0, input_fmt
    la a1, n  
    call scanf

    ld s0, n             
    addi t0, s0, 0       
    li t1, 0          

    count_digits:
        ble t0, zero, count_done
        li t2, 10
        div t0, t0, t2
        addi t1, t1, 1
        beq x0, x0, count_digits

    count_done:
    addi s1, t1, 0   
    addi t0, s0, 0  
    li t3, 0         

    loop:
        ble t0, zero, sum_done

        li t2, 10
        rem t4, t0, t2
        div t0, t0, t2

        li t5, 1              
        addi t6, t1, 0        
        exponent_loop:
            ble t6, x0, exponent_done
            mul t5, t5, t4
            addi t6, t6, -1
            beq x0, x0, exponent_loop
        
        exponent_done:
            add t3, t3, t5
            addi t1, t1, -1
            beq x0, x0, loop
        
    sum_done:
        beq s0, t3, output_true
        la a0, output_false_fmt
        call printf
        beq x0, x0, end

    output_true:
    la a0, output_true_fmt
    call printf

    end:
        ld ra, 16(sp)
        ld s0, 8(sp)
        ld s1, 0(sp)
        addi sp, sp, 24

        ret