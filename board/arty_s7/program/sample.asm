lui r1, 0xFFF1
addi r2, r0, 1

lui r3, 0x6C6C
addi r3, r3, 0x6548
lui r4, 0x544B
addi r4, r4, 0x206F
lui r5, 0x2132
addi r5, r5, 0x3343
addi r6, r0, 0xD0A

sw r3, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r3, 8
sw r3, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r3, 8
sw r3, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r3, 8
sw r3, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

sw r4, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r4, 8
sw r4, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r4, 8
sw r4, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r4, 8
sw r4, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

sw r5, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r5, 8
sw r5, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r5, 8
sw r5, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r5, 8
sw r5, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

sw r6, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r6, 8
sw r6, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r6, 8
sw r6, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

srli r6, 8
sw r6, r1, 8
sw r2, r1, 0
sw r0, r1, 0
lbu r7, r1, 4
beq r7, r0, 4
jal r0, -12

lui r1, 0xFFF0
lui r2, 0x10
addi r3, r0, 16

mov r4, r0
mov r5, r0

addi r4, r4, 1
sw r4, r1, 0

addi r5, r5, 1
beq r5, r2, 4
jal r0, -12

beq r4, r3, 4
jal r0, -30
jal r0, -36