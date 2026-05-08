.data
    fmt_in: .asciz "%d"
    true_str: .string "TRUE\n"
    false_str: .string "FALSE\n"
    n: .word 0

.text
.globl main
.extern scanf
.extern printf

main:
    addi    sp,sp,-32

    sd      ra,24(sp)
    sd      s0,16(sp)   #no of digits
    sd      s1,8(sp)    #dummy
    sd      s2,0(sp)    #number

    la      a0,fmt_in
    la      a1,n
    call    scanf

    lw      s2,n
    mv      s1,s2
    li      s0,0
    li      t0,0
    li      t4,0

count:
    beq     s1,t0,dia_check

    li      t5,10
    div     s1,s1,t5
    addi    s0,s0,1

    j       count

    mv      s1,s2

dia_check:
    beq     s0,t0,check

    rem     t1,s1,t5
    div     s1,s1,t5

    mv      t2,s0
    mv      t3,t1
power:
    beq     t2,t0,add_number

    mul     t3,t3,t1
    addi    t2,t2,-1
    j       power

add_number:
    add     t4,t4,t3
    addi    s0,s0,-1
    j       dia_check

check:
    beq     t4,s2,true_answer

    la      a0,false_str
    call    printf

    j       end

true_answer:
    la      a0,true_str
    call    printf

end:
    li      a0,0
    ld      s0,16(sp)
    ld      s1,8(sp)
    ld      s2,0(sp)

    addi    sp,sp,32
    ret

