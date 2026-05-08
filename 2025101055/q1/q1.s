.section .data

input_fmt: .string "%lld"
output_fmt: .string "%lld\n"

n: .dword 0
arr: .space 8000

.section .text

.global main
main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)
    sd s0, 0(sp)

    la a0, input_fmt
    la a1, n
    call scanf

    ld s0, n
    li s1, 0     
    la s2, arr 

    read_input:
        bge s1, s0, read_done

        addi t0, s1, 0
        slli t0, t0, 3
        add t1, s2, t0

        la a0, input_fmt
        addi a1, t1, 0
        call scanf

        addi s1, s1, 1
        beq x0, x0, read_input

    read_done:
        ld t1, 0(s2)
        li t5, -1000001
        add t2, t5, x0

        li s1, 1

    loop:
        bge s1, s0, loop_ended
        
        addi t0, s1, 0
        slli t0, t0, 3
        add t0, s2, t0

        ld t3, 0(t0)

        bgt t3, t1, largest_change
        beq t3, t1, next_elem
        bgt t3, t2, second_larg_change

        beq x0, x0, next_elem

        largest_change:
            addi t4, t1, 0
            addi t1, t3, 0
            addi t2, t4, 0
            beq x0, x0, next_elem

        second_larg_change:
            addi t2, t3, 0
            beq x0, x0, next_elem

        next_elem:
            addi s1, s1, 1
            beq x0, x0, loop

    loop_ended:

        la a0, output_fmt
        addi a1, t2, 0
        call printf

    end:
        ld ra, 24(sp)
        ld s0, 16(sp)
        ld s1, 8(sp)
        ld s0, 0(sp)
        addi sp, sp, 32

        ret