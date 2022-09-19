# KTC32

Hobby CPU implemented in SystemVerilog

## Features

- 32bit processor
- 32 registers
- RISC
- implemented in SystemVerilog

This CPU was based on the book "デイビット・マネー・ハリス、サラ・L・ハリス (2009) 『ディジタル電子回路とコンピュータアーキテクチャ 第 2 版』(天野英晴・鈴木貢・中條拓伯・永松礼夫訳) 翔泳社"(Digital Design and Computer Architecture Second Edition)

## Instruction Set

KTC32 has three formats of instruction.

![instruction formats](docs/instruction_formats.drawio.png)

| Instruction | Format | Opcode | Description                        | Assembly            |
| ----------- | ------ | ------ | ---------------------------------- | ------------------- |
| MOV         | R      | 000000 | x[rs1/rd] = x[rs2]                 | mov rs1/rd,rs2      |
| ADD         | R      | 100000 | x[rd] = x[rs1] + x[rs2]            | add rs1/rd, rs2     |
| SUB         | R      | 110000 | x[rd] = x[rs1] - x[rs2]            | sub rs1/rd, rs2     |
| AND         | R      | 010000 | x[rd] = x[rs1] & x[rs2]            | and rs1/rd, rs2     |
| OR          | R      | 011000 | x[rd] = x[rs1] \| x[rs2]           | or rs1/rd, rs2      |
| SLT         | R      | 001000 | x[rd] = (x[rs1] < x[rs2])? 1 : 0   | slt rs1/rd, rs2     |
| LW          | I      | 000011 | x[rd] = M[x[rs] + imm]             | lw rd, offset(rs)   |
| ADDI        | I      | 100011 | x[rd] = x[rs] + imm                | addi rd, rs, imm    |
| SW          | S/J    | 000111 | M[x[rs2] + imm] = x[rs1]           | sw rs1, offset(rs2) |
| JMP         | S/J    | 000001 | PC = PC + imm                      | jmp imm             |
| JEQ         | S/J    | 100001 | if(x[rs1] == x[rs2]) PC = PC + imm | jeq rs1, rs2, imm   |

## Running Test Benches

```bash
make
```
