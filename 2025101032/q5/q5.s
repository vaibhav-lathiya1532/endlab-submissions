.section .data
infmt : .asciz "%lld"
outfmt : .asciz "%lld "
newline : .asciz "\n"
num : .dword 0
hi : .asciz "Hello\n"
.section .text
.extern malloc
.extern printf
.extern scanf
.globl main
main:
    addi sp, sp, -16
    sd ra, 8(sp)
    la a0, infmt
    la a1, num
    call scanf
    la t0, num
    ld s0, 0(t0)                #s0------------->num
    mul t1, s0, s0
    slli t1, t1, 3
    mv a0, t1
    call malloc
    mv s1, a0                   #s1------------->arr pointer pointing to (0,0)
    li s2, 0
input_loop:
    bge s2, s0, transpose
    li s3, 0
inner_loop:
    bge s3, s0, next_row
    mul s4, s2, s0
    add s4, s4, s3
    slli s4, s4, 3
    add s4, s4, s1
    la a0, infmt
    mv a1, s4
    call scanf
    addi s3, s3, 1
    j inner_loop

next_row:
    addi s2, s2, 1                      
    j input_loop


# logic : First transpose and then (c-logic)
# i = 0, j = n-1
# while(i<j)
# for(p<3){
#    swap(arr[p][i], arr[p][j])
# }
# i++,j--



transpose:
    li s2, 0                        #s2------>row
out_loop:
    bge s2, s0, next                    #s3----->col
    li s3, 0
inn_loop:
    bge s2, s3, next_inn
    bge s3, s0, next_out
    mul s4, s2, s0
    add s4, s4, s3
    slli s4, s4, 3
    add s4, s4, s1
    mul s5, s3, s0
    add s5, s5, s2
    slli s5, s5, 3
    add s5, s5, s1
    ld s6, 0(s4)
    ld s7, 0(s5)
    sd s7, 0(s4)
    sd s6, 0(s5)
    j next_inn

next_out:
    addi s2, s2, 1
    j out_loop
next_inn:
    addi s3, s3, 1
    j inn_loop
next:
    li s2, 0
    addi s3, s0, -1
    
swap:
    bge s2, s3, end
    li s4, 0                #s4-------->row
inner:
    bge s4, s0, decrement
    mul s5, s4, s0
    add s5,s5, s2
    slli s5, s5, 3
    add s5, s5, s1
    mul s6, s4, s0
    add s6, s6, s3
    slli s6, s6, 3
    add s6, s6, s1
    ld t2, 0(s5)
    ld t3, 0(s6)
    sd t3, 0(s5)
    sd t2, 0(s6)
    addi s4, s4, 1
    j inner
decrement:
    addi s2, s2, 1
    addi s3, s3, -1
    j swap

end:
    li s2, 0
print_outer:
    bge s2, s0, exit
    li s3, 0
innerr_loop:
    bge s3, s0, nextt_row
    mul s4, s2, s0
    add s4, s4, s3
    slli s4, s4, 3
    add s4, s4, s1
    la a0, outfmt
    ld a1, 0(s4)
    call printf
    addi s3, s3, 1
    j innerr_loop

nextt_row:
    la a0, newline
    call printf
    addi s2, s2, 1                      
    j print_outer
exit:
    ld ra, 8(sp)
    addi sp, sp, 16
    li a0, 0
    ret

