 start:
	lui r1, 0xfff0
	lui r2, 0x10
	addi r3, r0, 16
	mov r4, r0

turn_on_led:
	sw r4, r1, 0
	mov r5, r0

wait:
	addi r5, r5, 1
	beq r5, r2, 4
	jal r0, wait

count_up_led:
	addi r4, r4, 1
	bnq r4, r3, 2
	mov r4, r0
	jal r0, turn_on_led