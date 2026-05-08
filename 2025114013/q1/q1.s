.section .rodata
    llint: .string "%lld"
    print_true: .string "TRUE\n"
    print_false: .string "FALSE\n"
.section .bss
    n: .space 8
    arr: .space 800000
.section .text

.global main

main:
    la a0, llint
    la a1, n
    call scanf

    la s0, n
    ld s0, 0(s0)
    la s1, arr

    # scan the array
    li s3, 0

    scanning:
        bge s3, s0, initchecking
        # while(i < n)
        mv t1, s3       # t1 => offset calculation and load
        slli t1, t1, 3
        add t1, s1, t1  # t1 => + arr
        la a0, llint
        mv a1, t1
        call scanf
        addi s3, s3, 1
        j scanning

    initchecking:
        li t0, 1
        li t1, 1        # constant value 1
        li s2, 1        # true
        beq s0, t1, onlyoneelement

    checking:
        bge t0, s0, foundtrue
        # while(i < n)  # i = 1 at initialisation
        addi t2, t0, -1
        slli t2, t2, 3
        add t2, t2, s1
        ld t2, 0(t2)    # t2 => arr[i - 1]

        mv t3, t0
        slli t3, t3, 3 
        add t3, t3, s1
        ld t3, 0(t3)    # t3 => arr[i]

        andi t4, t2, 1
        andi t5, t3, 1

        beq t4, t5, foundfalse

        truesofar:
            addi t0, t0, 1
            j checking

onlyoneelement:
    li s2, 0    # change if 1 means true
    la a0, print_false
    call printf
    ret

foundfalse:
    li s2, 0
    la a0, print_false
    call printf
    ret

beq s2, t1, foundtrue

foundtrue:
    la a0, print_true
    call printf
    ret