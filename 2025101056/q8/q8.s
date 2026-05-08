.data
in_fmt: .string"%lld"
out_fmt: .string"%lld\n"
target: .string"%lld"

N: .dword 0
arr: .space 800000


.text
.global main
main:
    addi sp, sp, 32
    sd ra, 24(sp)

    la a0, in_fmt
    la a1, N 
    call scanf

    ld t0, N
    li t1, 0 #i=0

r1:
    bge t1, t0, r2
    
    slli t2, t1, 3 #i*8(offset)
    la t3, arr
    add t3, t3, t2

    la a0, in_fmt
    la a1, t3
    call scanf

    addi t1, t1, 1
    j r1

r2:
    la a0, in_fmt
    la a1, target
    call scanf

    ld t1, a1 # t1=target

    li t2, 0 #low=t2=0
    addi t3, t0, -1 #high=t3=N-1

bs:
    bgt t2, t3, not_found #left>right -> not found 

    add t4, t3, t2 
    srai t4, t4, 1 #t4=mid=((high+low)/2)

    slli t4, t4, 3 # *8(1 byte=8bits)
    la t5, arr
    add t5, t5, t4 #t5=arr[mid]

    beq t5, t1, found

    slli t2, t2, 3
    la t6, arr
    add t6, t6, t2 #t6=arr[low]

    slli t3, t3, 3
    la a2, arr
    add a2, a2, t3 #a2=arr[high]

    ble t6, t5, left_loop

right_loop:
    bgt t1, a2, move_left
    j read_l
read_l:
    ble t5, t1, bs
    
left_loop:
    blt t1, t6, move_right
    j read_r
read_r:
    bge t5, t1, bs
    

move_left:
    addi t3, t4, -1

move_right:
    addi t2, t4, 1

found:
    la a0, out_fmt
    la a1, t4
    call printf
    j end
not_found:
    la ao, out_fmt
    li a1, -1
    call printf
    j end

end:
    ld ra, 24(sp)
    addi sp, sp, 32

    li a0, 0
    ret
    