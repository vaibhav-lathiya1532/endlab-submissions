.data
in: .string "%s"
out: .string "%ld\n"

.text
.global main

main:
addi sp,sp,-256
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)
sd s4,40(sp)

la a0,in
ld a1,

end:
li a0,0

ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
ld s4,40(sp)
addi sp,sp,256
