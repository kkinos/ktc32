module controller (
    input logic clk,
    input logic reset,

    input logic [5:0] opcode,
    input logic flag,

    output logic pcen,

    output logic iord,
    output logic regdst,
    output logic [1:0] memtoreg,
    output logic [1:0] alusrca,
    output logic [1:0] alusrcb,
    output logic [4:0] alucontrol,
    output logic pcsrc,

    output logic [1:0] memwrite,
    output logic irwrite,
    output logic [2:0] regwrite
);

  logic branch;
  logic pcwrite;

  always_comb begin
    pcen = pcwrite | (branch & flag);
  end

  parameter MOV = 6'b000000;
  parameter ADD = 6'b000001;
  parameter SUB = 6'b000010;
  parameter AND = 6'b000011;
  parameter OR = 6'b000100;
  parameter XOR = 6'b000101;
  parameter SLL = 6'b000110;
  parameter SRL = 6'b000111;
  parameter SRA = 6'b001000;
  parameter SLT = 6'b001001;
  parameter SLTU = 6'b001010;
  parameter SLLI = 6'b010000;
  parameter SRLI = 6'b010001;
  parameter SRAI = 6'b010010;
  parameter ADDI = 6'b100000;
  parameter ANDI = 6'b100001;
  parameter ORI = 6'b100010;
  parameter XORI = 6'b100011;
  parameter SLTI = 6'b100100;
  parameter SLTIU = 6'b100101;
  parameter BEQ = 6'b100110;
  parameter BNQ = 6'b100111;
  parameter BLT = 6'b101000;
  parameter BGE = 6'b101001;
  parameter BLTU = 6'b101010;
  parameter BGEU = 6'b101011;
  parameter JALR = 6'b101100;
  parameter LB = 6'b101101;
  parameter LH = 6'b101110;
  parameter LBU = 6'b101111;
  parameter LHU = 6'b110000;
  parameter LW = 6'b110001;
  parameter LUI = 6'b110010;
  parameter SB = 6'b110011;
  parameter SH = 6'b110100;
  parameter SW = 6'b110101;
  parameter JAL = 6'b111111;

  typedef enum logic [3:0] {
    S0,
    S1,
    S2,
    S3,
    S4,
    S5,
    S6,
    S7,
    S8,
    S9,
    S10,
    S11,
    S12,
    S13,
    S14,
    S15
  } statetype;
  statetype state, nextstate;

  always_ff @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else state <= nextstate;

  always_comb
    case (state)
      S0: begin
        nextstate = S1;

        iord = 1'b0;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b00;
        alusrcb = 2'b01;
        alucontrol = 4'b0001;
        pcsrc = 1'b0;

        memwrite = 2'b00;
        irwrite = 1'b1;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b1;
      end

      S1: begin
        case (opcode)
          MOV: nextstate = S6;
          ADD: nextstate = S6;
          SUB: nextstate = S6;
          AND: nextstate = S6;
          OR: nextstate = S6;
          XOR: nextstate = S6;
          SLL: nextstate = S6;
          SRL: nextstate = S6;
          SRA: nextstate = S6;
          SLT: nextstate = S6;
          SLTU: nextstate = S6;
          SLLI: nextstate = S9;
          SRLI: nextstate = S9;
          SRAI: nextstate = S9;
          ADDI: nextstate = S11;
          ANDI: nextstate = S11;
          ORI: nextstate = S11;
          XORI: nextstate = S11;
          SLTI: nextstate = S11;
          SLTIU: nextstate = S11;
          BEQ: nextstate = S10;
          BNQ: nextstate = S10;
          BLT: nextstate = S10;
          BGE: nextstate = S10;
          BLTU: nextstate = S10;
          BGEU: nextstate = S10;
          JALR: nextstate = S12;
          LB: nextstate = S2;
          LH: nextstate = S2;
          LBU: nextstate = S2;
          LHU: nextstate = S2;
          LW: nextstate = S2;
          LUI: nextstate = S11;
          SB: nextstate = S2;
          SH: nextstate = S2;
          SW: nextstate = S2;
          JAL: nextstate = S12;
          default: nextstate = S0;
        endcase

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b00;
        alusrcb = 2'b10;
        alucontrol = 4'b0001;
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S2: begin
        case (opcode)
          LB: nextstate = S3;
          LH: nextstate = S3;
          LBU: nextstate = S3;
          LHU: nextstate = S3;
          LW: nextstate = S3;
          SB: nextstate = S5;
          SH: nextstate = S5;
          SW: nextstate = S5;
          default: nextstate = S0;
        endcase

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b10;
        alusrcb = 2'b10;
        alucontrol = 5'b00001;
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S3: begin
        nextstate = S4;

        iord = 1'b1;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S4: begin
        nextstate = S0;

        iord = 'x;
        regdst = 1'b0;
        memtoreg = 2'b01;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        case (opcode)
          LB: regwrite = 3'b010;
          LH: regwrite = 3'b100;
          LBU: regwrite = 3'b001;
          LHU: regwrite = 3'b011;
          LW: regwrite = 3'b101;
          default: regwrite = 'x;
        endcase

        branch  = 1'b0;
        pcwrite = 1'b0;
      end

      S5: begin
        nextstate = S0;

        iord = 1'b1;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b10;
        alusrcb = 2'b10;
        alucontrol = 5'b00001;
        pcsrc = 'x;

        case (opcode)
          SB: memwrite = 2'b01;
          SH: memwrite = 2'b10;
          SW: memwrite = 2'b11;
          default: memwrite = 'x;
        endcase
        irwrite  = 1'b0;
        regwrite = 3'b000;

        branch   = 1'b0;
        pcwrite  = 1'b0;
      end

      S6: begin
        case (opcode)
          MOV, ADD, SUB, AND, OR, XOR, SLL, SRL, SRA: nextstate = S7;
          SLT, SLTU: nextstate = S8;
          default: nextstate = S0;
        endcase

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b10;
        alusrcb = 2'b00;
        case (opcode)
          MOV: alucontrol = 5'b00000;
          ADD: alucontrol = 5'b00001;
          SUB: alucontrol = 5'b00010;
          AND: alucontrol = 5'b00011;
          OR: alucontrol = 5'b00100;
          XOR: alucontrol = 5'b00101;
          SLL: alucontrol = 5'b00110;
          SRL: alucontrol = 5'b00111;
          SRA: alucontrol = 5'b01000;
          SLT: alucontrol = 5'b01110;
          SLTU: alucontrol = 5'b01011;
          default: alucontrol = 'x;
        endcase
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S7: begin
        nextstate = S0;

        iord = 'x;
        regdst = 1'b0;
        memtoreg = 2'b00;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b101;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S8: begin
        nextstate = S0;

        iord = 'x;
        regdst = 1'b1;
        memtoreg = 2'b00;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b101;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S9: begin
        nextstate = S7;

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b01;
        alusrcb = 2'b00;
        case (opcode)
          SLLI: alucontrol = 5'b00110;
          SRLI: alucontrol = 5'b00111;
          SRAI: alucontrol = 5'b01000;
          default: alucontrol = 'x;
        endcase
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S10: begin
        nextstate = S0;

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b10;
        alusrcb = 2'b00;
        case (opcode)
          BEQ: alucontrol = 5'b01001;
          BNQ: alucontrol = 5'b01010;
          BLT: alucontrol = 5'b01110;
          BGE: alucontrol = 5'b10000;
          BLTU: alucontrol = 5'b01011;
          BGEU: alucontrol = 5'b01101;
          default: alucontrol = 'x;
        endcase
        pcsrc = 1'b1;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b1;
        pcwrite = 1'b0;
      end

      S11: begin
        nextstate = S7;

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b10;
        alusrcb = 2'b10;
        case (opcode)
          ADDI: alucontrol = 5'b00001;
          ANDI: alucontrol = 5'b00011;
          ORI: alucontrol = 5'b00100;
          XORI: alucontrol = 5'b00101;
          SLTI: alucontrol = 5'b01111;
          SLTIU: alucontrol = 5'b01100;
          LUI: alucontrol = 5'b10001;
          default: alucontrol = 'x;
        endcase
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S12: begin
        case (opcode)
          JALR: nextstate = S13;
          JAL: nextstate = S14;
          default: nextstate = S0;
        endcase

        iord = 'x;
        regdst = 1'b0;
        memtoreg = 2'b10;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;
        pcsrc = 'x;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b101;

        branch = 1'b0;
        pcwrite = 1'b0;
      end

      S13: begin
        nextstate = S0;

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b10;
        alusrcb = 2'b10;
        alucontrol = 5'b00001;
        pcsrc = 1'b0;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b1;
      end

      S14: begin
        nextstate = S0;

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 2'b00;
        alusrcb = 2'b11;
        alucontrol = 5'b00001;
        pcsrc = 1'b0;

        memwrite = 2'b00;
        irwrite = 1'b0;
        regwrite = 3'b000;

        branch = 1'b0;
        pcwrite = 1'b1;
      end

      default: begin
        nextstate = S0;

        iord = 'x;
        regdst = 'x;
        memtoreg = 'x;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;
        pcsrc = 'x;

        memwrite = 'x;
        irwrite = 'x;
        regwrite = 'x;

        branch = 'x;
        pcwrite = 'x;
      end
    endcase
endmodule
