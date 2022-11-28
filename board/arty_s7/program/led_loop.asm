mov r1, r0
lui r9, r9, -16
addi r3, r0, 32767

mov r2, r0

addi r1, r1, 1
sw r1, r9, 0

addi r2, r2, 1
beq r2, r3, 4
jal r0, -12

addi r4, r0, 16
beq r1, r4, 4
jal r0, -34
jal r0, -48