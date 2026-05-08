.section .rodata
FMTIN: .string "%d"
FMTOUT: .string "%s"
FMTOUTD: .string "%d\n"
TRUE: .string "TRUE\n"    #ask for new line
FALSE: .string "FALSE\n"
.section .text
.globl main
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)           #n
    sd s1, 40(sp)           #sum
    sd s2, 32(sp)           #string length
    sd s3, 24(sp)           #instantaneous power val
    sd s4, 16(sp)           #digit
    sd s5, 8(sp)
    j input
input:
    addi a1, sp, 0
    la a0, FMTIN
    #call scanf now
    call scanf
    #store input
    lw s0, 0(sp)
    j smth
smth:
    li s2, 0                #length returner
    mv t0, s0               # t0 = n
    li t1, 10               #t1 = 10
    li t4, 0                #index iterator for power
    li s1, 0                #init sum = 0
    li s5, 1
    mv t2, s0
    j length_find

length_find:
    beq t0, x0, extract_digits
    div t0, t0, t1          #t0 = t0/t1
    addi s2, s2, 1          # s2++
    j length_find               

extract_digits:
    beq t4, s0, done
    rem s4, t2, t1          #get digit
    div t2, t2, t1          #t2 = t2/t1
    mv t5, t4               #duplicate index for subtracting
    sub t5, s0, t5          #t5 = n-(i)
    addi t4, t4, 1          #t4++ [0, n-1]
    li s3, 1                #instantaneous exp val
    j power
power:
    beq t5, x0, get_sum
    mul s3, s3, s4          # s3 = [s3]*digit
    addi t5, t5, -1         #t5-- 
    j power 
get_sum: 
    add s1, s1, s3         #sum+=expo_digit
    j extract_digits
done:
    beq s1, s0, input_done
    j SAME_PARITY
input_done:
    la a0, FMTOUT
    la a1, TRUE
    call printf
    j restore
SAME_PARITY:
    la a0, FMTOUT
    la a1, FALSE
    call printf
    j restore

restore:
    ld ra, 56(sp)
    ld s0, 48(sp)           #n
    ld s1, 40(sp)           #sum
    ld s2, 32(sp)          
    ld s3, 24(sp)
    ld s4, 16(sp)
    ld s5, 8(sp)
    addi sp, sp, 64
    mv a0, x0
    ret
