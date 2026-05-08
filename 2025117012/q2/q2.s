.section .rodata
    fmt_in:
        .string "%d %d"
    fmt_out:
        .string "%d %d\n"

.section .text
.globl main
main:
    add sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)                   # s0 = m
    sd s1, 24(sp)                   # s1 = n
    sd s2, 16(sp)                   # s2 = gcd(m,n)
    sd s3, 8(sp)                    # s3 = lcm(m,n)

    lla a0, fmt_in                  # a0 is %lld %lld
    sd a1, 0(s0)                    # a1 = &m
    sd a2, 0(s1)                    # a2 = &n    
    call scanf                      # scanf takes a1 and a2

    mul s4, a1, a2                  # s4 = m*n
    ble a1, a2, m_lt_n              #if a1<=a2 branch to m<n

m_gt_n:
    rem t0, a1, a2                  # t0 = m%n
    beqz t0, return_gcd             # if m%n==0: goto return_gcd
    addi a1, a2, 0                  # m becomes n
    addi a2, t0, 0                  # n becomes m%n
    j m_gt_n                        # recursive loop

m_lt_n:
    rem t0, a2, a1                  # t0 = n%m
    beqz t0, return_gcd             # if n%m==0, goto return_gcd
    addi a2, a1, 0                  # n becomes m
    addi a1, t0, 0                  # m becomes n%m
    j m_lt_n                        # recursive loop

return_gcd:                         # return value at a1 and a2
    div a2, s4, a1
    lla a0, fmt_out
    call printf
    add sp, sp, 48
    ret