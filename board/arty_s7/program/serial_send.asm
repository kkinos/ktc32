start:
	lui r1, 0xfff1
	addi r2, r0, 1
	addi r3, r0, msg

load_msg:
	lbu r4, r3, 0
	addi r3, r3, 1
	bnq r4, r0, 4
	jal r0, -4

send_msg:
	sw r4, r1, 4

wait_msg:
	lbu r5, r1, 0
	beq r5, r0, 4
	jal r0, wait_msg
	jal r0, load_msg

msg:
	0x6c6c6548
	0x544b206f
	0x21323343
	0xD0A