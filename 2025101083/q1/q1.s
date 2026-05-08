.section .rodata
fmt_in: .string "%lld"
fmt_out: .string "%lld"

.text
.global main
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)
    
    la a0, fmt_in
    mv a1, sp
    call scanf
    
    ld s0, 0(sp)
    li s1, -2000000000
    li s2, -2000000000
    li s3, 0

loop:
    bge s3, s0, done
    
    la a0, fmt_in
    mv a1, sp
    call scanf
    
    ld t0, 0(sp)
    
    ble t0, s1, check_second
    mv s2, s1
    mv s1, t0
    j next

check_second:
    beq t0, s1, next
    ble t0, s2, next
    mv s2, t0

next:
    addi s3, s3, 1
    j loop

done:
    la a0, fmt_out
    mv a1, s2
    call printf
    
    li a0, 0
    ld s3, 8(sp)
    ld s2, 16(sp)
    ld s1, 24(sp)
    ld s0, 32(sp)
    ld ra, 40(sp)
    addi sp, sp, 48
    ret