.section .rodata
fmt1:
    .string "%d"
fmt2:
    .string "%d\n"
.section .text
.globl main
main:
    addi sp, sp, -80
    sd ra, 0(sp)
    sd s0, 8(sp)   #n
    sd s1, 16(sp)  #lar
    sd s2, 24(sp)  #2nd
    lla a0, fmt1
    addi a1, sp, 72
    call scanf
    lw s0, 72(sp)
    li s1, -1000001
    li s2, -1000001
loop:
    beq s0, x0, end
    lla a0, fmt1
    addi a1, sp, 72
    call scanf
    lw t0, 72(sp)
    bgt t0, s1, foundLarger
    bgt t0, s2, foundSecond
    jal x0, cont
foundLarger:
    addi s2, s1, 0
    addi s1, t0, 0 
    jal x0, cont
foundSecond:
    bne t0, s1, valid
    jal x0, cont
valid:
    addi s2, t0, 0
    jal x0, cont
cont:
    addi s0, s0, -1
    jal x0, loop
end:
    lla a0, fmt2
    addi a1, s2, 0
    call printf
    ld ra, 0(sp)
    ld s0, 8(sp)   #n
    ld s1, 16(sp)  #lar
    ld s2, 24(sp)  #2nd
    addi sp, sp, 80
    jalr x0, 0(ra)



