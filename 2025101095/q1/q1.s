.data
fmtin: .asciz "%lld"
n: .dword 0
input_arr: .space 400
least: .dword -1000001
fmtout: .asciz "%lld\n"
.text
.global main
main:
    addi sp,sp,-96
    sd ra,0(sp)
    sd s1,8(sp)
    sd s2,16(sp)
    sd s3,24(sp)
    sd s4,32(sp)
    sd s5,40(sp)
    sd s6,48(sp)
    sd s7,56(sp)
    sd s8,64(sp)
    sd s9,72(sp)
    sd s10,80(sp)
    sd s11,88(sp);

    la a0,fmtin
    la a1,n
    call scanf

    la t0,n
    ld s0,0(t0)         #s0=n
    addi s0,s0,-1       #s0=s0-1 i.e., s0=n-1(const)
    addi s1,x0,0        #s1=0(changes)
    la s2,input_arr     #s2=input_arr address(const)
    la t0,least
    ld s3,0(t0)         #s3(here s3 is highest value)(changes)
    ld s10,0(t0)       #s10(here s10 is 2nd highest value)(changes)
    call store_ra
    addi s1,x0,0        #put again s1=0(changes)
    call cal
    la a0,fmtout
    mv a1,s10
    call printf
    ld s11,88(sp)
    ld s10,80(sp)
    ld s9,72(sp)
    ld s8,64(sp)
    ld s7,56(sp)
    ld s6,48(sp)
    ld s5,40(sp)
    ld s4,32(sp)
    ld s3,24(sp)
    ld s2,16(sp)
    ld s1,8(sp)
    ld ra,0(sp)
    addi sp,sp,96
    addi a0,x0,0
    ret
store_ra:
    addi sp,sp,-16
    sd ra,8(sp)
read_arr:
    beq s1,s0,read_done
    add s5,x0,s1
    slli s5,s5,2
    add s5,s5,s2        #s5=current taking address value
    la a0,fmtin
    mv a1,s5
    call scanf
    ld s4,0(s5)         #s4=current value in s5
    bgt s4,s3,change_highest
    addi s1,s1,1
    j read_arr
change_highest:
    addi s3,s4,0        #if current is higher than 
    addi s1,s1,1    
    j read_arr
read_done:
    ld ra,8(sp)
    addi sp,sp,16
    ret
cal:
    addi sp,sp,-16
    sd ra,8(sp)
calculate_second_highest:
    beq s1,s0,calculation_done
    add s5,x0,s1
    slli s5,s5,2
    add t0,s5,s2        #s5=current taking address value
    ld s4,0(t0)         #s4=current value in s5
    blt s4,s3,checkif2ndhighest
    addi s1,s1,1
    j calculate_second_highest
checkif2ndhighest:
    blt s10,s4,yes_higher
    addi s1,s1,1
    j calculate_second_highest
yes_higher:
    addi s10,s4,0
    addi s1,s1,1
    j calculate_second_highest
calculation_done:
    ld ra,8(sp)
    addi sp,sp,16
    ret
    
