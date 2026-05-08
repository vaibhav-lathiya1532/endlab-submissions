/*long long int n;
scanf("%lld",&n);
long long int arr[n];

for ( long long int i = 0 ; i < n ; i ++ ){
    scanf("%lld",&n);
}

int par = -1;
int next_par = -1;

#parity for Even = 0 and Odd = 1
int is_true = 1;

for ( long long int i = 0 ; i < n - 1; i++ ){

    if ( arr[i]%2 == 0 ){
        par = 0;
    }
    else{
        par = 1;
    }
    if ( arr[i+1]%2 == 0 ){
        next_par = 0;
    }
    else{
        next_par = 1;
    }
    if ( par == next_par ){
        is_true = 0;
        break;
    }
}

if( is_true == 0 ){
    printf("FALSE\n");
}
else{
    printf("TRUE\n");
}*/


.section .data
fmt_in: .asciz "%lld"
fmt_true: .asciz "TRUE\n"
fmt_false: .asciz "FALSE\n"
#fmt_debugmalloc: .asciz "Malloced\n"
#mt_debugarraryread: .asciz "Read\n"
#mt_elementscanned: .asciz "Scanned\n"
#mt_rem: .asciz "rem\n"

.section .text
.globl main

main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s6,48(sp)    #i
    sd s5,40(sp)    #is_true
    sd s4,32(sp)    #par
    sd s3,24(sp)    #prev_par
    sd s2,16(sp)    #arr base address
    sd s1,8(sp)     #N
    #0(sp) for scanf

    la a0,fmt_in
    add a1,sp,x0
    call scanf
    ld s1,0(sp)
 #   la a0,fmt_in
 #   add a1,s1,x0
 #  call printf

    slli t0,s1,3    #t0 = N*8
    add a0,t0,x0
    call malloc
    add s2,a0,x0    #s2 = arr
 #   la a0,fmt_debug
 #   call printf

    add s6,x0,x0    #i = 0

readloop:
 #  la a0,fmt_in
  # add a1,s6,x0
  # call printf
    bge s6,s1,readdone

    add t1,s6,x0    #t1 = i 
    slli t1,t1,3    #t1 = i*8
    add t1,s2,t1    #t1 = &arr[i]
    add t2,t1,x0
    la a0,fmt_in
    add a1,t2,x0
    call scanf
    ld t1,0(t2)
 #  la a0,fmt_elementscanned
 #  call printf
#    la a0,fmt_in
 #   add a1,t1,x0
 #   call printf

    addi s6,s6,1
    jal x0,readloop

readdone:
 #  la a0,fmt_debugarraryread
 #  call printf
    add s6,x0,x0
    addi s3,x0,-1
    addi s4,x0,-1
    addi s5,x0,1
    addi t0,s1,-1

evallooppar:
    addi t0,s1,-1
 # la a0,fmt_in
 #  add a1,t0,x0
 #  call printf
    bge s6,t0,exit
    add t3,s2,x0
    slli t1,s6,3
    add t3,t3,t1    #t3 = &arr[i]
    ld t4,0(t3)     #t4 = arr[i]
    addi t5,x0,2
    rem t4,t4,t5    #arr[i]%2
 #  la a0,fmt_rem
 #  call printf
    addi t6,x0,1
    beq t4,t6,parodd
    addi s4,x0,0
    jal x0,evalloopnextpar

parodd:
    addi s4,x0,1
    jal x0,evalloopnextpar

evalloopnextpar:
    ld t4,8(t3)
    addi t5,x0,2
    rem t4,t4,t5
    addi t6,x0,1
    beq t4,t6,nextparodd
    addi s3,x0,0
    beq s3,s4,istruefalse
    jal x0,istrue

nextparodd:
    addi s3,x0,1
    beq s3,s4,istruefalse
    jal x0,istrue

istruefalse:
#   la a0,fmt_false
#   call printf
    addi s5,s5,0
    la a0,fmt_false
    call printf
    jal x0,cleanup

istrue:
    addi s6,s6,1
    jal x0,evallooppar

exit:
 #  la a0,fmt_false
 #  call printf
#   beq s5,x0,printfalse
    la a0,fmt_true
    call printf
    jal x0,cleanup

cleanup:

    ld a0,8(sp)
    call free

    ld ra,56(sp)
    ld s6,48(sp)    #i
    ld s5,40(sp)    #is_true
    ld s4,32(sp)    #par
    ld s3,24(sp)    #prev_par
    ld s2,16(sp)    #arr base address
    ld s1,8(sp)     #N
    addi sp,sp,64

    jalr x0,0(ra)