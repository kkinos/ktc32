start_serial_send:
	lui r1, 0xfff1
	addi r2, r0, 1
	addi r3, r0, msg

load_msg:
	lbu r4, r3, 0
	addi r3, r3, 1
	bnq r4, r0, 4
	jal r0, start_led_loop

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

start_led_loop:
	lui r1, 0xfff0
	lui r2, 0x10
	addi r3, r0, 16
	mov r4, r0

turn_on_led:
	sw r4, r1, 0
	mov r5, r0

wait:
	lui r6, 0xfff1
	lbu r7, r6, 0x8
	beq r7, r0, 4
	jal r0, start_echo_back
	addi r5, r5, 1
	beq r5, r2, 4
	jal r0, wait

count_up_led:
	addi r4, r4, 1
	bnq r4, r3, 2
	mov r4, r0
	jal r0, turn_on_led

start_echo_back:
	lui r1, 0xfff1
	addi r2, r0, 1
	addi r3, r0, 2

loop:
	jal r4, getc
	jal r4, putc
	jal r0, loop

getc:
	lbu r5, r1, 0x8
	andi r5, r5, 2
	beq r5, r3, 4
	jal r0, load_zero
	lbu r6, r1, 0xc
	jalr r0, r4, 0

load_zero:
	mov r6, r0
	jalr r0, r4, 0

putc:
	lbu r7, r1, 0
	beq r7, r0, 4
	jal r0, putc
	sw r6, r1, 4
	jalr r0, r4, 0