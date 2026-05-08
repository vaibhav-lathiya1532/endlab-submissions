#logic:
#change = inserted - actual price
#inserted ko t0
#actual ko t1
#change t2 = t0-t1

#ab ek count 25 ko t4 mei
#agr change less than 25 then skip
#if not then t4+ &&
#li t5,0
#t2 = t2 - 25 and loop carry on

#same for count 10 ko t5 mei
#agr change less than 10 then skip
#if not then t5++ && t2 = t2 - 10 and loop carry on

#same for count 5 t0 mei
#agr change less than 5 then skip
#if not then t0++ && t2 = t2 - 5 and loop carry on

#now remaing change is count 1
#toh count 1 ko t6 mei store krlo and t6 = t2

#code:

.globalmain
.text


#change
li t5,0

sub t2,t0,t1

#count25
li t3,25
li t4,0

loop25:
blt t3,t4,skip25
sub t2,t2,25
addi t4,t4,1
j loop25  

skip25:

#count10
li t3,10
li t5,0

loop10:
blt t3,t4,skip10
sub t2,t2,10
addi t5,t5,1
j loop10

#count5
li t3,5
li t0,0

loop5:
blt t3,t4,skip5
sub t2,t2,5
addi t0,t0,1
j loop5

skip5:

#count1
addi t6,t6,t2

