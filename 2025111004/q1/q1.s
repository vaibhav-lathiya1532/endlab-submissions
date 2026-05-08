.data
fmt_in: .string "%d"
fmt_true: .string "TRUE\n"
fmt_false: .string "FALSE\n"
fmt_debug: .string "%d"

.text
.globl main
.extern printf
.extern scanf
.extern malloc

main:
    addi sp, sp, -80
    sd ra, 8(sp)

    addi a1, sp, 0
    lla a0, fmt_in
    call scanf
    
    lw s0, 0(sp) # n 
    # allocate
    slli a0, s0, 2
    call malloc
    sd a0, 16(sp) # at 16(sp), array is stored

    li s1, 0
    input_loop:
        bge s1, s0, input_done
        slli t1, s1, 2
        ld s2, 16(sp)
        add s2, s2, t1
        mv a1, s2
        lla a0, fmt_in
        call scanf
        addi s1, s1, 1
        j input_loop
    input_done:
    li s1, 0
    slli t1, s1, 2
    ld s2, 16(sp)
    add s2, s2, t1
    lw s1, 0(s2)
    li t0, 2
    rem s1, s1, t0 # prev = a[0]%2
    lw s0, 0(sp)
    li t0, 1
    loop:
        bge t0, s0, yes
        slli t1, t0, 2
        ld s2, 16(sp)
        add s2, s2, t1
        lw s3, 0(s2)
        li t2, 2
        rem s3, s3, t2
        beq s3, s1, no
        mv s1, s3
        addi t0, t0, 1
        j loop
    
    no:
        lla a0, fmt_false
        call printf
        j done
    yes:
        lla a0, fmt_true
        call printf
        j done

    done:
    ld ra, 8(sp)
    addi sp, sp, 80
    ret 
        
