.section .rodata
scan_fmt: .string "%lld"
print_fmt: .string "%lld\n"

.global main
.text

main:
    addi sp, sp, -80
    sd x1, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)

    lla a0, scan_fmt
    addi a1, sp, 0
    call scanf
    ld s0, 0(sp)     #s0 = n

    mv a0, s0
    slli a0, a0, 3
    call malloc
    mv s1, a0           #s1 = address to malloc

    mv s2, s0
    mv s3, s1

scan_loop:
    beqz s2, done_scanning
    addi s2, s2, -1

    lla a0, scan_fmt
    addi a1, s3, 0
    call scanf
    addi s3, s3, 8
    j scan_loop

done_scanning:
    mv s2, s0
    mv s3, s1
    addi s4, x0, 0      #s4 = ans

loop:
    beqz s2, end
    addi s2, s2, -1
    ld s5, 0(s3)
    addi s3, s3, 8
    addi t0, x0, 1
    beq s5, t0, loop
    addi t0, x0, 2
    beq t0, s5, lol
    div s6, s5, t0
    
check:
    bgt t0, s6, lol
    rem t1, s5, t0
    beqz t1, found
    addi t0, t0, 1
    j check

found:
    j loop

lol:
    add s4, s4, s5
    j loop

end:
    lla a0, print_fmt
    addi a1, s4, 0
    call printf

    ld x1, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    addi sp, sp, 80
    ret
