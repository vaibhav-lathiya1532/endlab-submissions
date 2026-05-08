/*long long int n,m;
scanf("%lld %lld",&n,&m);
long long int change = m - n;

long long int q = 0;
while(change>25){
    change = change - 25;
    q++;
}
long long int d = 0;
while(change>10){
    change = change - 10;
    d++;
}
long long int n = 0;
while(change>5){
    change = change - 5;
    n++;
}
printf("%lld %lld %lld %lld\n",q,d,n,change);*/

.section .data
fmt_in: .asciz "%lld %lld"
fmt_out: .asciz "%lld %lld %lld %lld\n"

.section .text
.globl main

main:
    addi sp,sp,-80
    sd ra,64(sp)
    sd s6,56(sp)    #change
    sd s5,48(sp)    #n
    sd s4,40(sp)    #d
    sd s3,32(sp)    #q
    sd s2,24(sp)    #M
    sd s1,16(sp)     #N
    #0(sp) and 8(sp) for scanf

    la a0,fmt_in
    add a1,sp,x0
    addi a2,sp,8
    call scanf
    ld s1,0(sp)
    ld s2,8(sp)

    sub s6,s2,s1
    add s3,x0,x0
    add s4,x0,x0
    add s5,x0,x0

qloop:
    addi t0,x0,25
    bgt t0,s6,dloop
    addi s6,s6,-25
    addi s3,s3,1
    jal x0,qloop

dloop:
    addi t0,x0,10
    bgt t0,s6,nloop
    addi s6,s6,-10
    addi s4,s4,1
    jal x0,dloop

nloop:
    addi t0,x0,5
    bgt t0,s6,exit
    addi s6,s6,-5
    addi s5,s5,1
    jal x0,nloop

exit:
    la a0,fmt_out
    add a1,s3,x0
    add a2,s4,x0
    add a3,s5,x0
    add a4,s6,x0
    call printf

    ld ra,64(sp)
    ld s6,56(sp)    #change
    ld s5,48(sp)    #n
    ld s4,40(sp)    #d
    ld s3,32(sp)    #q
    ld s2,24(sp)    #M
    ld s1,16(sp)  
    addi sp,sp,80
    
    jalr x0,0(ra)
