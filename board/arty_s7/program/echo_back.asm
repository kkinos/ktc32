start_echo_back:
	lui r1, 0xfff1
	addi r2, r0, 1
	addi r3, r0, 2

loop:
	jal r4, getc
	jal r4, putc
	jal r0, loop

getc:
	lbu r5, r1, 0xc
	andi r5, r5, 2
	beq r5, r3, 4
	jal r0, load_zero
	lbu r6, r1, 0x10
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

