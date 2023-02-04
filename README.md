# KTC32

A hobby 32-bit CPU implemented in SystemVerilog.

- [KTC32](#ktc32)
	- [Instruction Set](#instruction-set)
	- [Peripherals](#peripherals)
	- [Design](#design)
		- [CPU](#cpu)
		- [Controller's FSM](#controllers-fsm)
	- [Running Test Benches](#running-test-benches)
		- [Required](#required)
	- [Related Projects](#related-projects)
		- [KTC32 assembler](#ktc32-assembler)
		- [KTC32 emulator](#ktc32-emulator)
	- [Reference](#reference)

## Instruction Set

KTC32 has four formats of instruction.

![instruction formats](docs/instruction_formats.drawio.png)

| Instruction | Format | Opcode | Description                                    | Assembly          |
| ----------- | ------ | ------ | ---------------------------------------------- | ----------------- |
| MOV         | R      | 000000 | x[rd] = x[rs]                                  | mov rd, rs        |
| ADD         | R      | 000001 | x[rd] = x[rd] + x[rs]                          | add rd, rs        |
| SUB         | R      | 000010 | x[rd] = x[rd] - x[rs]                          | sub rd, rs        |
| AND         | R      | 000011 | x[rd] = x[rd] & x[rs]                          | and rd, rs        |
| OR          | R      | 000100 | x[rd] = x[rd] \| x[rs]                         | or rd, rs         |
| XOR         | R      | 000101 | x[rd] = x[rd] \^ x[rs]                         | xor rd, rs        |
| SLL         | R      | 000110 | x[rd] = x[rd] << x[rs]                         | sll rd, rs        |
| SRL         | R      | 000111 | x[rd] = x[rd] >><sub>u</sub> x[rs]             | srl rd, rs        |
| SRA         | R      | 001000 | x[rd] = x[rd] >><sub>s</sub> x[rs]             | sra rd, rs        |
| SLT         | R      | 001001 | flag = (x[rd] <<sub>s</sub> x[rs])? 1 : 0      | slt rd, rs        |
| SLTU        | R      | 001010 | flag = (x[rd] <<sub>u</sub> x[rs])? 1 : 0      | sltu rd, rs       |
| SLLI        | I16    | 010000 | x[rd] = x[rd] << imm                           | slli rd, imm      |
| SRLI        | I16    | 010001 | x[rd] = x[rd] >><sub>u</sub> imm               | srli rd, imm      |
| SRAI        | I16    | 010010 | x[rd] = x[rd] >><sub>s</sub> imm               | srai rd, imm      |
| ADDI        | I32    | 100000 | x[rd] = x[rs] + sext(imm)                      | addi rd, rs, imm  |
| ANDI        | I32    | 100001 | x[rd] = x[rs] & sext(imm)                      | andi rd, rs, imm  |
| ORI         | I32    | 100010 | x[rd] = x[rs] \| sext(imm)                     | ori rd, rs, imm   |
| XORI        | I32    | 100011 | x[rd] = x[rs] \^ sext(imm)                     | xori rd, rs, imm  |
| SLTI        | I32    | 100100 | x[rd] = (x[rs] <<sub>s</sub> sext(imm))? 1 : 0 | slti rd, rs, imm  |
| SLTIU       | I32    | 100101 | x[rd] = (x[rs] <<sub>u</sub> sext(imm))? 1 : 0 | sltiu rd, rs, imm |
| BEQ         | I32    | 100110 | if(x[rd] == x[rs]) pc += sext(imm)             | beq rd, rs, imm   |
| BNQ         | I32    | 100111 | if(x[rd] != x[rs]) pc += sext(imm)             | bnq rd, rs, imm   |
| BLT         | I32    | 101000 | if(x[rd] <<sub>s</sub> x[rs]) pc += sext(imm)  | blt rd, rs, imm   |
| BGE         | I32    | 101001 | if(x[rd] >=<sub>s</sub> x[rs]) pc += sext(imm) | bge rd, rs, imm   |
| BLTU        | I32    | 101010 | if(x[rd] <<sub>u</sub> x[rs]) pc += sext(imm)  | bltu rd, rs, imm  |
| BGEU        | I32    | 101011 | if(x[rd] >=<sub>u</sub> x[rs]) pc += sext(imm) | bgeu rd, rs, imm  |
| JALR        | I32    | 101100 | x[rd] = pc, pc = (x[rs] + sext(imm))           | jalr rd, rs, imm  |
| LB          | I32    | 101101 | x[rd] = sext(M[x[rs] + sext(imm)][7:0])        | lb rd, rs, imm    |
| LH          | I32    | 101110 | x[rd] = sext(M[x[rs] + sext(imm)][15:0])       | lh rd, rs, imm    |
| LBU         | I32    | 101111 | x[rd] = M[x[rs] + sext(imm)][7:0]              | lbu rd, rs, imm   |
| LHU         | I32    | 110000 | x[rd] = M[x[rs] + sext(imm)][15:0]             | lhu rd, rs, imm   |
| LW          | I32    | 110001 | x[rd] = M[x[rs] + sext(imm)]                   | lw rd, rs, imm    |
| LUI         | I32    | 110010 | x[rd] = sext(imm) << 16                        | lui rd, imm       |
| SB          | I32    | 110011 | M[x[rs] + sext(imm)] = x[rd][7:0]              | sb rd, rs, imm    |
| SH          | I32    | 110100 | M[x[rs] + sext(imm)] = x[rd][15:0]             | sh rd, rs, imm    |
| SW          | I32    | 110101 | M[x[rs] + sext(imm)] = x[rd]                   | sw rd, rs, imm    |
| JAL         | J      | 111111 | x[rd] = pc, pc += sext(imm)                    | jal rd, imm       |

## Peripherals

| Address    | Name           | Bit   | Description                                                                                   | Read/Write |
| ---------- | -------------- | ----- | --------------------------------------------------------------------------------------------- | ---------- |
| 0xfff00000 | LED_DATA       | [3:0] | 0 : off 1 : on                                                                                | Read/Write |
| 0xfff10000 | UART_TX_STATUS | [0]   | 0 : idle 1 : transmitting                                                                     | Read Only  |
| 0xfff10004 | UART_TX_DATA   | [7:0] | when this register written, start to transmit data                                            | Read/Write |
| 0xfff10008 | UART_RX_STATUS | [1:0] | bit 0 UART status<br> 0 : idle 1 : receiving<br>bit 1 data validity<br> 0 : invalid 1 : valid | Read Only  |
| 0xfff1000c | UART_RX_DATA   | [7:0] | when read this register, data validity changes to invalid                                     | Read Only  |

## Design

### CPU

![rtl](docs/rtl.drawio.png)

### Controller's FSM

![fsm](docs/fsm.drawio.png)

## Running Test Benches

```bash
make
```

### Required

- [ktc32-asm](https://github.com/kinpoko/ktc32-asm)

- Icarus Verilog

## Related Projects

### KTC32 assembler

[ktc32-asm](https://github.com/kinpoko/ktc32-asm)

### KTC32 emulator

[ktc32-emu](https://github.com/kinpoko/ktc32-emu)

## Reference

- デイビット・マネー・ハリス、サラ・L・ハリス (2009) 『ディジタル電子回路とコンピュータアーキテクチャ 第 2 版』(天野英晴・鈴木貢・中條拓伯・永松礼夫訳) 翔泳社 (Digital Design and Computer Architecture Second Edition)

- 中森章 (2022) 「FPGA 初心者は自作マイコンの夢を見るか？ RISC-V on FPGA 実装計画 第 2 回 UART の実装」 『Interface』 2022 年 9 月号, CQ 出版社
