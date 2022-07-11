# KTC16

Hobby CPU implemented in SystemVerilog

## Features

- 16bit processor
- 32 registers
- RISC
- implemented in SystemVerilog

This CPU was based on the book "デイビット・マネー・ハリス、サラ・L・ハリス (2009) 『ディジタル電子回路とコンピュータアーキテクチャ 第 2 版』(天野英晴・鈴木貢・中條拓伯・永松礼夫訳) 翔泳社"(Digital Design and Computer Architecture Second Edition)

## Instruction Set

KTC16 has three formats of instruction.

![instruction formats](docs/instruction_formats.drawio.png)

| Instruction | Format | Opcode | Description                      |
| ----------- | ------ | ------ | -------------------------------- |
| MOV         | R      | 000000 | x[rd] = x[rs1]                   |
| ADD         | R      | 100000 | x[rd] = x[rs1] + x[rs2]          |
| SUB         | R      | 110000 | x[rd] = x[rs1] - x[rs2]          |
| AND         | R      | 010000 | x[rd] = x[rs1] & x[rs2]          |
| OR          | R      | 011000 | x[rd] = x[rs1] \| x[rs2]         |
| SLT         | R      | 001000 | x[rd] = (x[rs1] < x[rs2])? 1 : 0 |
| LW          | I      | 000011 | x[rd] = M[x[rs] + imm]           |
| ADDI        | I      | 100011 | x[rd] = x[rs] + imm              |
| SW          | S/J    | 000111 | M[x[rs1] + imm] = x[rs2]         |
| JMP         | S/J    | 000001 | PC = imm                         |
| JEQ         | S/J    | 100001 | if(x[rs1] == x[rs2]) PC = imm    |
