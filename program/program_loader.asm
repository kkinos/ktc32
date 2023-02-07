start:
	lui r1, 0xfff1
	addi r2, r0, 2
	jal r0, check_header

// address 12
return:
	lui r1, 0xfff1
	lbu r2, r1, 0
	beq r2, r0, 4
	jal r0, -12
	sb r4, r2, 4
	srli r4, 8
	lbu r2, r1, 0
	beq r2, r0, 4
	jal r0, -12
	sb r4, r2, 4
	srli r4, 8
	lbu r2, r1, 0
	beq r2, r0, 4
	jal r0, -12
	sb r4, r2, 4
	srli r4, 8
	lbu r2, r1, 0
	beq r2, r0, 4
	jal r0, -12
	sb r4, r2, 4
	jal r0, start

check_header:
	jal r3, read_data
	mov r5, r0
	or r5, r4
	jal r3, read_data
	slli r4, 8
	or r5, r4
	jal r3, read_data
	slli r4, 16
	or r5, r4
	jal r3, read_data
	slli r4, 24
	or r5, r4
	addi r6, r0, 256
	mov r7, r0
	mov r8, r6
	jal r0, load_program

read_data:
	lbu r4, r1, 0x8
	andi r4, r4, 2
	beq r4, r2, 4
	jal r0, read_data
	lbu r4, r1, 0xc
	jalr r0, r3, 0

load_program:
	jal r3, read_data
	sb r4, r6, 0
	addi r6, r6, 1
	addi r7, r7, 1
	beq r7, r5, 4
	jal r0, load_program
	jal r0, init
	
init:
	mov r1, r0
	mov r2, r0
	mov r3, r0
	mov r4, r0
	mov r5, r0
	mov r6, r0
	mov r7, r0
	mov r8, r0
	mov r9, r0
	mov r10, r0
	mov r11, r0
	mov r12, r0
	mov r13, r0
	mov r14, r0
	mov r15, r0
	mov r16, r0
	mov r17, r0
	mov r18, r0
	mov r19, r0
	mov r20, r0
	mov r21, r0
	mov r22, r0
	mov r23, r0
	mov r24, r0
	mov r25, r0
	mov r26, r0
	mov r27, r0
	mov r28, r0
	mov r29, r0
	mov r30, r0
	mov r31, r0
	jalr r0, r8, 0