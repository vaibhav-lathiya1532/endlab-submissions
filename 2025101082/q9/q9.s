.section .data
    fmt_in: .string "%lld"
    fmt_yes: .string "1\n"
    fmt_no: .string "0\n"
    
.section .text

.globl .main
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s1, 32(sp) #n
    sd s2, 24(sp) #iter
    sd s3, 16(sp) #sum

    la a0, fmt_in
    call scanf
    la s1, a1

    li s2, 0
    li s3, 0
    mv t4, s1
    mv t0, s1
    li t1, 100
    li t2, 1
    li t3, 10
loop:
    bge s2, t1, end_loop
    beq s1, t2, end_loop
    addi s2, s2, 1
mod_loop:
    blt t0, t3, end_mod_loop
    addi t0, t0, -10
    j mod_loop
end_mod_loop:
    # t0 = digit
    mul t0, t0, t0
    add s3, s3, t0 # sum+=digit^2
    mv s1, s3
div_loop:
    li t5, 0
    blt t4, t3, end_div_loop
    addi t4, t4, -10
    addi t5, t5, 1
    j div_loop
end_div_loop:
    mv t0, t5
    mv t4, t5
    j mod_loop
replace:
    mv s1, s3
    j loop
end_loop:
    beq s1, t2, print_yes
    la a0, fmt_no
    call printf
    j exit
print_yes:
    la a0, fmt_yes
    call printf
    j exit
exit:
    ld ra, 40(sp)
    ld s1, 32(sp)
    ld s2, 24(sp)
    ld s3, 16(sp)
    addi sp, sp, 48
    ret
