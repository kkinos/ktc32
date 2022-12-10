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

jal r0, -4